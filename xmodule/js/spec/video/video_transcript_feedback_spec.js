(function() {
    // eslint-disable-next-line lines-around-directive
    'use strict';

    describe('VideoTranscriptFeedback', function() {
        var state;
        var videoId = "365b710a-6dd6-11ee-b962-0242ac120002";
        var userId = 1;
        var currentLanguage = "en";
        var getAITranscriptUrl = '/video-transcript' + '?transcript_language=' + currentLanguage + '&video_uuid=' + videoId;
        var getTranscriptFeedbackUrl = '/transcript-feedback' + '?transcript_language=' + currentLanguage + '&video_uuid=' + videoId + '&user_id=' + userId;
        var sendTranscriptFeedbackUrl = '/transcript-feedback/';

        beforeEach(function() {
            state = jasmine.initializePlayer('video_transcript_feedback.html');
        });

        afterEach(function() {
            $('source').remove();
            state.storage.clear();
            if (state.videoPlayer) {
                state.videoPlayer.destroy();
            }
        });

        describe('initialize', function() {
            it('instantiates widget and handlers along with necessary data', function() {
                spyOn(state.videoTranscriptFeedback, 'instantiateWidget').and.callFake(function() {
                    return true;
                });
                spyOn(state.videoTranscriptFeedback, 'bindHandlers').and.callFake(function() {
                    return true;
                });
                state.videoTranscriptFeedback.initialize();

                expect(state.videoTranscriptFeedback.videoId).toEqual(videoId);
                expect(state.videoTranscriptFeedback.userId).toEqual(userId);
                expect(state.videoTranscriptFeedback.currentTranscriptLanguage).toEqual(currentLanguage);
                expect(state.videoTranscriptFeedback.instantiateWidget).toHaveBeenCalled();
                expect(state.videoTranscriptFeedback.bindHandlers).toHaveBeenCalled();
            });
        });

        describe('instantiates widget', function() {
            it('checks if transcript was AI generated', function() {
                spyOn(state.videoTranscriptFeedback, 'shouldShowWidget').and.callThrough();
                state.videoTranscriptFeedback.instantiateWidget();

                var getAITranscriptCall = $.ajax.calls.all().find(function(call) {
                    return call.args[0].url.match(/.+video-transcript.+$/);
                });

                expect(state.videoTranscriptFeedback.shouldShowWidget).toHaveBeenCalled();
                expect(getAITranscriptCall.args[0].url).toEqual(state.videoTranscriptFeedback.aiTranslationsUrl + getAITranscriptUrl);
                expect(getAITranscriptCall.args[0].type).toEqual('GET');
                expect(getAITranscriptCall.args[0].async).toEqual(false);
                expect(getAITranscriptCall.args[0].success).toEqual(jasmine.any(Function));
                expect(getAITranscriptCall.args[0].error).toEqual(jasmine.any(Function));
            });
            it('shows widget if transcript is AI generated', function() {
                state.videoTranscriptFeedback.instantiateWidget();
                expect($('.wrapper-transcript-feedback')[0]).toExist();
            });
            it('hides widget if transcript is not AI generated', function() {
                spyOn(state.videoTranscriptFeedback, 'shouldShowWidget').and.callFake(function() {
                    return false;
                });
                state.videoTranscriptFeedback.instantiateWidget();
                expect($('.wrapper-transcript-feedback')[0]).toExist();
                expect($('.wrapper-transcript-feedback')[0].style.display).toEqual('none');
            });
            it('checks if feedback exists for AI generated transcript', function() {
                spyOn(state.videoTranscriptFeedback, 'getFeedbackForCurrentTranscript').and.callThrough();
                state.videoTranscriptFeedback.instantiateWidget();

                var getTranscriptFeedbackCall = $.ajax.calls.all().find(function(call) {
                    return call.args[0].url.match(/.+transcript-feedback.+$/);
                });

                expect(state.videoTranscriptFeedback.getFeedbackForCurrentTranscript).toHaveBeenCalled();
                expect(getTranscriptFeedbackCall.args[0].url).toEqual(state.videoTranscriptFeedback.aiTranslationsUrl + getTranscriptFeedbackUrl);
                expect(getTranscriptFeedbackCall.args[0].type).toEqual('GET');
                expect(getTranscriptFeedbackCall.args[0].success).toEqual(jasmine.any(Function));
                expect(getTranscriptFeedbackCall.args[0].error).toEqual(jasmine.any(Function));
            });
        });

        describe('onHideLanguageMenu', function() {
            it('calls instantiateWidget if language changed', function() {
                state.videoTranscriptFeedback.currentTranscriptLanguage = 'es';
                spyOn(state.videoTranscriptFeedback, 'instantiateWidget').and.callThrough();
                state.el.trigger('language_menu:hide', {
                    id: 'id',
                    code: 'code',
                    language: 'en',
                    duration: 10
                });
                expect(state.videoTranscriptFeedback.instantiateWidget).toHaveBeenCalled();
            });
            it('does not call instantiateWidget if language did not change', function() {
                state.videoTranscriptFeedback.currentTranscriptLanguage = 'en';
                spyOn(state.videoTranscriptFeedback, 'instantiateWidget').and.callThrough();
                state.el.trigger('language_menu:hide', {
                    id: 'id',
                    code: 'code',
                    language: 'en',
                    duration: 10
                });
                expect(state.videoTranscriptFeedback.instantiateWidget).not.toHaveBeenCalled();
            });
        });

        describe('clicking on thumbs up button', function() {
            it('sends positive feedback if there is no current feedback', function() {
                state.videoTranscriptFeedback.instantiateWidget();
                state.videoTranscriptFeedback.currentFeedback = undefined;
                spyOn(state.videoTranscriptFeedback, 'sendFeedbackForCurrentTranscript').and.callFake(function() {
                    return true;
                });
                var thumbsUpButton = $('.thumbs-up-btn');
                thumbsUpButton.trigger('click');
                expect(state.videoTranscriptFeedback.sendFeedbackForCurrentTranscript).toHaveBeenCalledWith(true);
            });
            it('sends empty feedback if there is a current positive feedback', function() {
                state.videoTranscriptFeedback.instantiateWidget();
                state.videoTranscriptFeedback.currentFeedback = true;
                spyOn(state.videoTranscriptFeedback, 'sendFeedbackForCurrentTranscript').and.callFake(function() {
                    return true;
                });
                var thumbsUpButton = $('.thumbs-up-btn');
                thumbsUpButton.trigger('click');
                expect(state.videoTranscriptFeedback.sendFeedbackForCurrentTranscript).toHaveBeenCalledWith(null);
            });
        });

        describe('clicking on thumbs down button', function() {
            it('sends negative feedback if there is no current feedback', function() {
                state.videoTranscriptFeedback.instantiateWidget();
                state.videoTranscriptFeedback.currentFeedback = undefined;
                spyOn(state.videoTranscriptFeedback, 'sendFeedbackForCurrentTranscript').and.callFake(function() {
                    return true;
                });
                var thumbsDownButton = $('.thumbs-down-btn');
                thumbsDownButton.trigger('click');
                expect(state.videoTranscriptFeedback.sendFeedbackForCurrentTranscript).toHaveBeenCalledWith(false);
            });
            it('sends empty feedback if there is a current negative feedback', function() {
                state.videoTranscriptFeedback.instantiateWidget();
                state.videoTranscriptFeedback.currentFeedback = false;
                spyOn(state.videoTranscriptFeedback, 'sendFeedbackForCurrentTranscript').and.callFake(function() {
                    return true;
                });
                var thumbsDownButton = $('.thumbs-down-btn');
                thumbsDownButton.trigger('click');
                expect(state.videoTranscriptFeedback.sendFeedbackForCurrentTranscript).toHaveBeenCalledWith(null);
            });
        });

        describe('calling send transcript feedback', function() {
            it('sends proper request to ai translation service', function() {
                state.videoTranscriptFeedback.instantiateWidget();
                state.videoTranscriptFeedback.currentFeedback = undefined;
                state.videoTranscriptFeedback.sendFeedbackForCurrentTranscript(true);
                var sendTranscriptFeedbackCall = $.ajax.calls.all().find(function(call) {
                    return call.args[0].url.match(/.+transcript-feedback.+$/) && call.args[0].type === 'POST';
                });

                expect(sendTranscriptFeedbackCall.args[0].url).toEqual(state.videoTranscriptFeedback.aiTranslationsUrl + sendTranscriptFeedbackUrl);
                expect(sendTranscriptFeedbackCall.args[0].type).toEqual('POST');
                expect(sendTranscriptFeedbackCall.args[0].dataType).toEqual('json');
                expect(sendTranscriptFeedbackCall.args[0].data).toEqual({
                    transcript_language: currentLanguage,
                    video_uuid: videoId,
                    user_id: userId,
                    value: true,
                });
                expect(sendTranscriptFeedbackCall.args[0].success).toEqual(jasmine.any(Function));
                expect(sendTranscriptFeedbackCall.args[0].error).toEqual(jasmine.any(Function));
            });
            it('marks thumbs up button as selected if response is positive', function() {
                state.videoTranscriptFeedback.instantiateWidget();
                state.videoTranscriptFeedback.currentFeedback = undefined;
                state.videoTranscriptFeedback.sendFeedbackForCurrentTranscript(true);
                var thumbsUpIcon = $('.thumbs-up-icon')[0];
                var thumbsDownIcon = $('.thumbs-down-icon')[0];

                expect(thumbsUpIcon.classList).toContain('fa-thumbs-up');
                expect(thumbsDownIcon.classList).toContain('fa-thumbs-o-down');
                expect(state.videoTranscriptFeedback.currentFeedback).toEqual(true);
            });
            it('marks thumbs down button as selected if response is negative', function() {
                state.videoTranscriptFeedback.instantiateWidget();
                state.videoTranscriptFeedback.currentFeedback = undefined;
                state.videoTranscriptFeedback.sendFeedbackForCurrentTranscript(false);
                var thumbsUpIcon = $('.thumbs-up-icon')[0];
                var thumbsDownIcon = $('.thumbs-down-icon')[0];

                expect(thumbsUpIcon.classList).toContain('fa-thumbs-o-up');
                expect(thumbsDownIcon.classList).toContain('fa-thumbs-down');
                expect(state.videoTranscriptFeedback.currentFeedback).toEqual(false);
            });
            it('unselects thumbs buttons if response is empty', function() {
                state.videoTranscriptFeedback.instantiateWidget();
                state.videoTranscriptFeedback.currentFeedback = true;
                state.videoTranscriptFeedback.sendFeedbackForCurrentTranscript(null);
                var thumbsUpIcon = $('.thumbs-up-icon')[0];
                var thumbsDownIcon = $('.thumbs-down-icon')[0];

                expect(thumbsUpIcon.classList).toContain('fa-thumbs-o-up');
                expect(thumbsDownIcon.classList).toContain('fa-thumbs-o-down');
                expect(state.videoTranscriptFeedback.currentFeedback).toEqual(null);
            });
        });
    });
}).call(this);
