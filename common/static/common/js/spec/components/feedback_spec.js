// Generated by CoffeeScript 1.6.1
(function() {

  define(["jquery", "common/js/components/views/feedback", "common/js/components/views/feedback_notification", "common/js/components/views/feedback_alert", "common/js/components/views/feedback_prompt", 'common/js/spec_helpers/view_helpers', "sinon", "jquery.simulate"],
    function($, SystemFeedback, NotificationView, AlertView, PromptView, ViewHelpers, sinon) {
    var tpl;
    tpl = readFixtures('common/templates/components/system-feedback.underscore');
    beforeEach(function() {
      setFixtures(sandbox({
        id: "page-alert"
      }));
      appendSetFixtures(sandbox({
        id: "page-notification"
      }));
      appendSetFixtures(sandbox({
        id: "page-prompt"
      }));
      appendSetFixtures($("<script>", {
        id: "system-feedback-tpl",
        type: "text/template"
      }).text(tpl));
      return jasmine.addMatchers({
        toBeShown: function() {
          return {
            compare: function (actual) {
              return {
                pass: actual.hasClass("is-shown") && !actual.hasClass("is-hiding")
              };
            }
          };
        },
        toBeHiding: function() {
          return {
            compare: function (actual) {
              return {
                pass: actual.hasClass("is-hiding") && !actual.hasClass("is-shown")
              };
            }
          };
        },
        toContainText: function() {
          return {
            compare: function (text) {
              var trimmedText,
                  passed;

              trimmedText = $.trim(this.actual.text());
              if (text && $.isFunction(text.test)) {
                passed = text.test(trimmedText);
              } else {
                passed = trimmedText.indexOf(text) !== -1;
              }
              return {
                pass: passed
              };
            }
          };
        },
        toHaveBeenPrevented: function() {
          return {
            compare: function (actual) {
              var eventName, selector;
              eventName = actual.eventName;
              selector = actual.selector;

              return {
                pass: jasmine.JQuery.events.wasPrevented(selector, eventName),
                message: "Expected event " + eventName + " to have been prevented on " + selector +
                "and Expected event " + eventName + " not to have been prevented on " + selector
              };
            }
          };
        }
      });
    });
    describe("SystemFeedback", function() {
      beforeEach(function() {
        this.options = {
          title: "Portal",
          message: "Welcome to the Aperture Science Computer-Aided Enrichment Center"
        };
        this.renderSpy = spyOn(AlertView.Confirmation.prototype, 'render').and.callThrough();
        this.showSpy = spyOn(AlertView.Confirmation.prototype, 'show').and.callThrough();
        this.hideSpy = spyOn(AlertView.Confirmation.prototype, 'hide').and.callThrough();
        return this.clock = sinon.useFakeTimers();
      });
      afterEach(function() {
        return this.clock.restore();
      });
      it("requires a type and an intent", function() {
        var both, neither, noIntent, noType,
          _this = this;
        neither = function() {
          return new SystemFeedback(_this.options);
        };
        noType = function() {
          var options;
          options = $.extend({}, _this.options);
          options.intent = "confirmation";
          return new SystemFeedback(options);
        };
        noIntent = function() {
          var options;
          options = $.extend({}, _this.options);
          options.type = "alert";
          return new SystemFeedback(options);
        };
        both = function() {
          var options;
          options = $.extend({}, _this.options);
          options.type = "alert";
          options.intent = "confirmation";
          return new SystemFeedback(options);
        };
        expect(neither).toThrow();
        expect(noType).toThrow();
        expect(noIntent).toThrow();
        return expect(both).not.toThrow();
      });
      it("does not show on initalize", function() {
        var view;
        view = new AlertView.Confirmation(this.options);
        expect(this.renderSpy).not.toHaveBeenCalled();
        return expect(this.showSpy).not.toHaveBeenCalled();
      });
      xit("renders the template", function() {
        var view;
        view = new AlertView.Confirmation(this.options);
        view.show();
        expect(view.$(".action-close")).toBeDefined();
        expect(view.$('.wrapper')).toBeShown();
        expect(view.$el).toContainText(this.options.title);
        return expect(view.$el).toContainText(this.options.message);
      });
      return xit("close button sends a .hide() message", function() {
        var view;
        view = new AlertView.Confirmation(this.options).show();
        view.$(".action-close").click();
        expect(this.hideSpy).toHaveBeenCalled();
        this.clock.tick(900);
        return expect(view.$('.wrapper')).toBeHiding();
      });
    });
    describe("PromptView", function() {
      beforeEach(function() {
        this.options = {
          title: "Confirming Something",
          message: "Are you sure you want to do this?",
          actions: {
            primary: {
              text: "Yes, I'm sure.",
              "class": "confirm-button"
            },
            secondary: {
              text: "Cancel",
              "class": "cancel-button"
            }
          }
        };
        this.inFocusSpy = spyOn(PromptView.Confirmation.prototype, 'inFocus').and.callThrough();
        return this.outFocusSpy = spyOn(PromptView.Confirmation.prototype, 'outFocus').and.callThrough();
      });
      it("is focused on show", function(done) {
        var view;
        view = new PromptView.Confirmation(this.options).show();
        expect(this.inFocusSpy).toHaveBeenCalled();
        jasmine.waitUntil(function () {
          return view.$(".wrapper-prompt" + ':focus').length === 1;
        }).always(done);
      });
      it("is not focused on hide", function(done) {
        var view;
        view = new PromptView.Confirmation(this.options).hide();
        expect(this.outFocusSpy).toHaveBeenCalled();

        jasmine.waitUntil(function () {
          return view.$(".wrapper-prompt" + ':focus').length === 0;
        }).always(done);
      });
      it("traps keyboard focus when moving forward", function(done) {
        var view;
        view = new PromptView.Confirmation(this.options).show();
        expect(this.inFocusSpy).toHaveBeenCalled();
        $('.action-secondary').first().simulate(
          "keydown",
          { keyCode: $.simulate.keyCode.TAB }
        );

        jasmine.waitUntil(function () {
          return view.$(".action-primary" + ':focus').length === 1;
        }).always(done);
      });
      it("traps keyboard focus when moving backward", function(done) {
        var view;
        view = new PromptView.Confirmation(this.options).show();
        expect(this.inFocusSpy).toHaveBeenCalled();
        $('.action-primary').first().simulate(
          "keydown",
          { keyCode: $.simulate.keyCode.TAB, shiftKey: true }
        );

        jasmine.waitUntil(function () {
          return view.$(".action-secondary" + ':focus').length === 1;
        }).always(done);
      });
      return it("changes class on body", function() {
        var view;
        view = new PromptView.Confirmation({
          title: "Portal",
          message: "Welcome to the Aperture Science Computer-Aided Enrichment Center"
        });
        return view.hide();
      });
    });
    describe("NotificationView.Mini", function() {
      beforeEach(function() {
        return this.view = new NotificationView.Mini();
      });
      it("should have minShown set to 1250 by default", function() {
        return expect(this.view.options.minShown).toEqual(1250);
      });
      return it("should have closeIcon set to false by default", function() {
        return expect(this.view.options.closeIcon).toBeFalsy();
      });
    });
    xdescribe("SystemFeedback click events", function() {
      beforeEach(function() {
        this.primaryClickSpy = jasmine.createSpy('primaryClick');
        this.secondaryClickSpy = jasmine.createSpy('secondaryClick');
        this.view = new NotificationView.Warning({
          title: "Unsaved",
          message: "Your content is currently Unsaved.",
          actions: {
            primary: {
              text: "Save",
              "class": "save-button",
              click: this.primaryClickSpy
            },
            secondary: {
              text: "Revert",
              "class": "cancel-button",
              click: this.secondaryClickSpy
            }
          }
        });
        return this.view.show();
      });
      it("should trigger the primary event on a primary click", function() {
        this.view.$(".action-primary").click();
        expect(this.primaryClickSpy).toHaveBeenCalled();
        return expect(this.secondaryClickSpy).not.toHaveBeenCalled();
      });
      it("should trigger the secondary event on a secondary click", function() {
        this.view.$(".action-secondary").click();
        expect(this.secondaryClickSpy).toHaveBeenCalled();
        return expect(this.primaryClickSpy).not.toHaveBeenCalled();
      });
      it("should apply class to primary action", function() {
        return expect(this.view.$(".action-primary")).toHaveClass("save-button");
      });
      it("should apply class to secondary action", function() {
        return expect(this.view.$(".action-secondary")).toHaveClass("cancel-button");
      });
      it("should preventDefault on primary action", function() {
        spyOnEvent(".action-primary", "click");
        this.view.$(".action-primary").click();
        return expect("click").toHaveBeenPreventedOn(".action-primary");
      });
      return it("should preventDefault on secondary action", function() {
        spyOnEvent(".action-secondary", "click");
        this.view.$(".action-secondary").click();
        return expect("click").toHaveBeenPreventedOn(".action-secondary");
      });
    });
    xdescribe("SystemFeedback not preventing events", function() {
      beforeEach(function() {
        this.clickSpy = jasmine.createSpy('clickSpy');
        this.view = new AlertView.Confirmation({
          title: "It's all good",
          message: "No reason for this alert",
          actions: {
            primary: {
              text: "Whatever",
              click: this.clickSpy,
              preventDefault: false
            }
          }
        });
        return this.view.show();
      });
      return it("should not preventDefault", function() {
        spyOnEvent(".action-primary", "click");
        this.view.$(".action-primary").click();
        expect("click").not.toHaveBeenPreventedOn(".action-primary");
        return expect(this.clickSpy).toHaveBeenCalled();
      });
    });
    xdescribe("SystemFeedback multiple secondary actions", function() {
      beforeEach(function() {
        this.secondarySpyOne = jasmine.createSpy('secondarySpyOne');
        this.secondarySpyTwo = jasmine.createSpy('secondarySpyTwo');
        this.view = new NotificationView.Warning({
          title: "No Primary",
          message: "Pick a secondary action",
          actions: {
            secondary: [
              {
                text: "Option One",
                "class": "option-one",
                click: this.secondarySpyOne
              }, {
                text: "Option Two",
                "class": "option-two",
                click: this.secondarySpyTwo
              }
            ]
          }
        });
        return this.view.show();
      });
      it("should render both", function() {
        expect(this.view.el).toContain(".action-secondary.option-one");
        expect(this.view.el).toContain(".action-secondary.option-two");
        expect(this.view.el).not.toContain(".action-secondary.option-one.option-two");
        expect(this.view.$(".action-secondary.option-one")).toContainText("Option One");
        return expect(this.view.$(".action-secondary.option-two")).toContainText("Option Two");
      });
      it("should differentiate clicks (1)", function() {
        this.view.$(".option-one").click();
        expect(this.secondarySpyOne).toHaveBeenCalled();
        return expect(this.secondarySpyTwo).not.toHaveBeenCalled();
      });
      return it("should differentiate clicks (2)", function() {
        this.view.$(".option-two").click();
        expect(this.secondarySpyOne).not.toHaveBeenCalled();
        return expect(this.secondarySpyTwo).toHaveBeenCalled();
      });
    });
    return describe("NotificationView minShown and maxShown", function() {
      beforeEach(function() {
        this.showSpy = spyOn(NotificationView.Confirmation.prototype, 'show');
        this.showSpy.and.callThrough();
        this.hideSpy = spyOn(NotificationView.Confirmation.prototype, 'hide');
        this.hideSpy.and.callThrough();
        return this.clock = sinon.useFakeTimers();
      });
      afterEach(function() {
        return this.clock.restore();
      });
      xit("should not have minShown or maxShown by default", function() {
        var view;
        view = new NotificationView.Confirmation();
        expect(view.options.minShown).toEqual(0);
        return expect(view.options.maxShown).toEqual(Infinity);
      });
      xit("a minShown view should not hide too quickly", function() {
        var view;
        view = new NotificationView.Confirmation({
          minShown: 1000
        });
        view.show();
        expect(view.$('.wrapper')).toBeShown();
        view.hide();
        expect(view.$('.wrapper')).toBeShown();
        this.clock.tick(1001);
        return expect(view.$('.wrapper')).toBeHiding();
      });
      xit("a maxShown view should hide by itself", function() {
        var view;
        view = new NotificationView.Confirmation({
          maxShown: 1000
        });
        view.show();
        expect(view.$('.wrapper')).toBeShown();
        this.clock.tick(1001);
        return expect(view.$('.wrapper')).toBeHiding();
      });
      xit("a minShown view can stay visible longer", function() {
        var view;
        view = new NotificationView.Confirmation({
          minShown: 1000
        });
        view.show();
        expect(view.$('.wrapper')).toBeShown();
        this.clock.tick(1001);
        expect(this.hideSpy).not.toHaveBeenCalled();
        expect(view.$('.wrapper')).toBeShown();
        view.hide();
        return expect(view.$('.wrapper')).toBeHiding();
      });
      xit("a maxShown view can hide early", function() {
        var view;
        view = new NotificationView.Confirmation({
          maxShown: 1000
        });
        view.show();
        expect(view.$('.wrapper')).toBeShown();
        this.clock.tick(50);
        view.hide();
        expect(view.$('.wrapper')).toBeHiding();
        this.clock.tick(1000);
        return expect(view.$('.wrapper')).toBeHiding();
      });
      return it("a view can have both maxShown and minShown", function() {
        var view;
        view = new NotificationView.Confirmation({
          minShown: 1000,
          maxShown: 2000
        });
        view.show();
        this.clock.tick(50);
        view.hide();
        expect(view.$('.wrapper')).toBeShown();
        this.clock.tick(1000);
        expect(view.$('.wrapper')).toBeHiding();
        view.show();
        this.clock.tick(1050);
        expect(view.$('.wrapper')).toBeShown();
        this.clock.tick(1000);
        return expect(view.$('.wrapper')).toBeHiding();
      });
    });
  });

}).call(this);
