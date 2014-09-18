define ["jquery", "coffee/src/courseware"],
    ($, Courseware) ->

    describe 'Courseware', ->
        describe 'start', ->
            it 'create the navigation', ->
                spyOn(window, 'Navigation')
                Courseware.start()
                expect(window.Navigation).toHaveBeenCalled()

            it 'binds the Logger', ->
                spyOn(Logger, 'bind')
                Courseware.start()
                expect(Logger.bind).toHaveBeenCalled()

        describe 'render', ->
            beforeEach ->
                jasmine.stubRequests()
                @courseware = new Courseware
                spyOn(window, 'Histogram')
                spyOn(window, 'Problem')
                spyOn(window, 'Video')
                spyOn(XBlock, 'initializeBlocks')
                setFixtures """
            <div class="course-content">
              <div id="video_1" class="video" data-streams="1.0:abc1234"></div>
              <div id="video_2" class="video" data-streams="1.0:def5678"></div>
              <div id="problem_3" class="problems-wrapper" data-problem-id="3" data-url="/example/url/">
                <div id="histogram_3" class="histogram" data-histogram="[[0, 1]]" style="height: 20px; display: block;">
              </div>
            </div>
            """
                @courseware.render()

            it 'ensure that the XModules have been loaded', ->
                expect(XBlock.initializeBlocks).toHaveBeenCalled()

            it 'detect the histrogram element and convert it', ->
                expect(window.Histogram).toHaveBeenCalledWith('3', [[0, 1]])
