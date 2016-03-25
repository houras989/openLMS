define(['backbone', 'jquery', 'underscore', 'moment', 'common/js/spec_helpers/ajax_helpers',
        'common/js/spec_helpers/template_helpers',
        'js/spec/student_account/helpers',
        'js/spec/student_profile/helpers',
        'js/student_profile/views/section_two_tab',
        'js/views/fields',
        'js/student_account/models/user_account_model'
    ],
    function (Backbone, $, _, Moment, AjaxHelpers, TemplateHelpers, Helpers, LearnerProfileHelpers,
              SectionTwoTabView, FieldViews, UserAccountModel) {
        "use strict";
        describe("edx.user.SectionTwoTab", function () {

            var createSectionTwoView = function (ownProfile, profileIsPublic) {
                
                var accountSettingsModel = new UserAccountModel();
                accountSettingsModel.set(Helpers.createAccountSettingsData());
                accountSettingsModel.set({'profile_is_public': profileIsPublic});
                accountSettingsModel.set({'profile_image': Helpers.PROFILE_IMAGE});

                var editable = ownProfile ? 'toggle' : 'never';

                var sectionTwoFieldViews = [
                    new FieldViews.TextareaFieldView({
                        model: accountSettingsModel,
                        editable: editable,
                        showMessages: false,
                        title: 'About me',
                        placeholderValue: "Tell other edX learners a little about yourself: where you live, " +
                            "what your interests are, why you're taking courses on edX, or what you hope to learn.",
                        valueAttribute: "bio",
                        helpMessage: '',
                        messagePosition: 'header'
                    })
                ];

                return new SectionTwoTabView({
                    viewList: sectionTwoFieldViews,
                    showFullProfile: function(){
                        return profileIsPublic;
                    },
                    ownProfile: ownProfile
                });
            };

            it("full profile displayed for public profile", function () {
                var view = createSectionTwoView(false, true);
                view.render();
                var bio = view.$el.find('.u-field-bio');
                expect(bio.length).toBe(1);
            });
            
            it("profile field parts are actually rendered for public profile", function () {
                var view = createSectionTwoView(false, true);
                _.each(view.options.viewList, function (fieldView) {
                    spyOn(fieldView, "render").andCallThrough();
                });
                view.render();
                _.each(view.options.viewList, function (fieldView) {
                    expect(fieldView.render).toHaveBeenCalled();
                });
            });

            var testPrivateProfile = function (ownProfile, msg_string) {
                var view = createSectionTwoView(ownProfile, false);
                view.render();
                var bio = view.$el.find('.u-field-bio');
                expect(bio.length).toBe(0);
                var msg = view.$el.find('span.profile-private--message');
                expect(msg.length).toBe(1);
                expect(_.count(msg.html(), msg_string)).toBeTruthy();
            };

            it("no profile when profile is private for other people", function () {
               testPrivateProfile(false, "This learner is currently sharing a limited profile");
            });

            it("no profile when profile is private for the user herself", function () {
               testPrivateProfile(true, "You are currently sharing a limited profile");
            });

            var testProfilePrivatePartsDoNotRender = function (ownProfile) {
                 var view = createSectionTwoView(ownProfile, false);
                _.each(view.options.viewList, function (fieldView) {
                     spyOn(fieldView, "render");
                });
                view.render();
                _.each(view.options.viewList, function (fieldView) {
                    expect(fieldView.render).not.toHaveBeenCalled();
                });
            };

            it("profile field parts are not rendered for private profile for owner", function () {
               testProfilePrivatePartsDoNotRender(true);
            });

            it("profile field parts are not rendered for private profile for other people", function () {
               testProfilePrivatePartsDoNotRender(false);
            });
            
            // TODO: Test editability (when ownProfile click should enable editing) --- check that proper request is sent
            // otherwise disable. 

        });
    }
);
