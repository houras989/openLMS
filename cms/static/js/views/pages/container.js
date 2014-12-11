/**
 * XBlockContainerPage is used to display Studio's container page for an xblock which has children.
 * This page allows the user to understand and manipulate the xblock and its children.
 */
define(["jquery", "underscore", "gettext", "js/views/pages/base_page", "js/views/utils/view_utils",
        "js/views/container", "js/views/xblock", "js/views/components/add_xblock", "js/views/modals/edit_xblock",
        "js/models/xblock_info", "js/views/xblock_string_field_editor", "js/views/pages/container_subviews",
        "js/views/unit_outline", "js/views/utils/xblock_utils", "js/views/modals/visibility_modal"],
    function ($, _, gettext, BasePage, ViewUtils, ContainerView, XBlockView, AddXBlockComponent,
              EditXBlockModal, XBlockInfo, XBlockStringFieldEditor, ContainerSubviews, UnitOutlineView,
              XBlockUtils, VisibilityModal) {
        'use strict';
        var XBlockContainerPage = BasePage.extend({
            // takes XBlockInfo as a model

            events: {
                "click .edit-button": "editXBlock",
                "click .visibility-button": "editVisibilitySettings",
                "click .duplicate-button": "duplicateXBlock",
                "click .delete-button": "deleteXBlock"
            },

            options: {
                collapsedClass: 'is-collapsed'
            },

            view: 'container_preview',

            initialize: function(options) {
                BasePage.prototype.initialize.call(this, options);
                this.nameEditor = new XBlockStringFieldEditor({
                    el: this.$('.wrapper-xblock-field'),
                    model: this.model
                });
                this.nameEditor.render();
                if (this.options.action === 'new') {
                    this.nameEditor.$('.xblock-field-value-edit').click();
                }
                this.xblockView = new ContainerView({
                    el: this.$('.wrapper-xblock'),
                    model: this.model,
                    view: this.view
                });
                this.messageView = new ContainerSubviews.MessageView({
                    el: this.$('.container-message'),
                    model: this.model
                });
                this.messageView.render();
                this.isUnitPage = this.options.isUnitPage;
                if (this.isUnitPage) {
                    this.xblockPublisher = new ContainerSubviews.Publisher({
                        el: this.$('#publish-unit'),
                        model: this.model,
                        // When "Discard Changes" is clicked, the whole page must be re-rendered.
                        renderPage: this.render
                    });
                    this.xblockPublisher.render();

                    this.publishHistory = new ContainerSubviews.PublishHistory({
                        el: this.$('#publish-history'),
                        model: this.model
                    });
                    this.publishHistory.render();

                    this.previewActions = new ContainerSubviews.PreviewActionController({
                        el: this.$('.nav-actions'),
                        model: this.model
                    });
                    this.previewActions.render();

                    this.unitOutlineView = new UnitOutlineView({
                        el: this.$('.wrapper-unit-overview'),
                        model: this.model
                    });
                    this.unitOutlineView.render();
                }
            },

            render: function(options) {
                var self = this,
                    xblockView = this.xblockView,
                    loadingElement = this.$('.ui-loading'),
                    unitLocationTree = this.$('.unit-location'),
                    hiddenCss='is-hidden';

                loadingElement.removeClass(hiddenCss);

                // Hide both blocks until we know which one to show
                xblockView.$el.addClass(hiddenCss);

                // Render the xblock
                xblockView.render({
                    done: function() {
                        // Show the xblock and hide the loading indicator
                        xblockView.$el.removeClass(hiddenCss);
                        loadingElement.addClass(hiddenCss);

                        // Notify the runtime that the page has been successfully shown
                        xblockView.notifyRuntime('page-shown', self);

                        // Render the add buttons
                        self.renderAddXBlockComponents();

                        // Refresh the views now that the xblock is visible
                        self.onXBlockRefresh(xblockView);
                        unitLocationTree.removeClass(hiddenCss);

                        // Re-enable Backbone events for any updated DOM elements
                        self.delegateEvents();
                    }
                });
            },

            findXBlockElement: function(target) {
                return $(target).closest('.studio-xblock-wrapper');
            },

            getURLRoot: function() {
                return this.xblockView.model.urlRoot;
            },

            onXBlockRefresh: function(xblockView) {
                this.xblockView.refresh();
                // Update publish and last modified information from the server.
                this.model.fetch();
            },

            renderAddXBlockComponents: function() {
                var self = this;
                this.$('.add-xblock-component').each(function(index, element) {
                    var component = new AddXBlockComponent({
                        el: element,
                        createComponent: _.bind(self.createComponent, self),
                        collection: self.options.templates
                    });
                    component.render();
                });
            },

            editXBlock: function(event) {
                var xblockElement = this.findXBlockElement(event.target),
                    self = this,
                    modal = new EditXBlockModal({ });
                event.preventDefault();

                modal.edit(xblockElement, this.model, {
                    refresh: function() {
                        self.refreshXBlock(xblockElement);
                    }
                });
            },

            editVisibilitySettings: function(event) {
                var xblockElement = this.findXBlockElement(event.target),
                    self = this,
                    modal = new VisibilityModal();
                event.preventDefault();

                modal.edit(xblockElement, this.model, {
                    refresh: function() {
                        self.refreshXBlock(xblockElement);
                    }
                });
            },

            duplicateXBlock: function(event) {
                event.preventDefault();
                this.duplicateComponent(this.findXBlockElement(event.target));
            },

            deleteXBlock: function(event) {
                event.preventDefault();
                this.deleteComponent(this.findXBlockElement(event.target));
            },

            createPlaceholderElement: function() {
                return $("<div/>", { class: "studio-xblock-wrapper" });
            },

            createComponent: function(template, target) {
                // A placeholder element is created in the correct location for the new xblock
                // and then onNewXBlock will replace it with a rendering of the xblock. Note that
                // for xblocks that can't be replaced inline, the entire parent will be refreshed.
                var parentElement = this.findXBlockElement(target),
                    parentLocator = parentElement.data('locator'),
                    buttonPanel = target.closest('.add-xblock-component'),
                    listPanel = buttonPanel.prev(),
                    scrollOffset = ViewUtils.getScrollOffset(buttonPanel),
                    placeholderElement = this.createPlaceholderElement().appendTo(listPanel),
                    requestData = _.extend(template, {
                        parent_locator: parentLocator
                    });
                return $.postJSON(this.getURLRoot() + '/', requestData,
                    _.bind(this.onNewXBlock, this, placeholderElement, scrollOffset))
                    .fail(function() {
                        // Remove the placeholder if the update failed
                        placeholderElement.remove();
                    });
            },

            duplicateComponent: function(xblockElement) {
                // A placeholder element is created in the correct location for the duplicate xblock
                // and then onNewXBlock will replace it with a rendering of the xblock. Note that
                // for xblocks that can't be replaced inline, the entire parent will be refreshed.
                var self = this,
                    parent = xblockElement.parent();
                ViewUtils.runOperationShowingMessage(gettext('Duplicating&hellip;'),
                    function() {
                        var scrollOffset = ViewUtils.getScrollOffset(xblockElement),
                            placeholderElement = self.createPlaceholderElement().insertAfter(xblockElement),
                            parentElement = self.findXBlockElement(parent),
                            requestData = {
                                duplicate_source_locator: xblockElement.data('locator'),
                                parent_locator: parentElement.data('locator')
                            };
                        return $.postJSON(self.getURLRoot() + '/', requestData,
                            _.bind(self.onNewXBlock, self, placeholderElement, scrollOffset))
                            .fail(function() {
                                // Remove the placeholder if the update failed
                                placeholderElement.remove();
                            });
                    });
            },

            deleteComponent: function(xblockElement) {
                var self = this,
                    xblockInfo = new XBlockInfo({
                        id: xblockElement.data('locator')
                    });
                XBlockUtils.deleteXBlock(xblockInfo).done(function() {
                    self.onDelete(xblockElement);
                });
            },

            onDelete: function(xblockElement) {
                // get the parent so we can remove this component from its parent.
                var xblockView = this.xblockView,
                    parent = this.findXBlockElement(xblockElement.parent());
                xblockElement.remove();

                // Inform the runtime that the child has been deleted in case
                // other views are listening to deletion events.
                xblockView.notifyRuntime('deleted-child', parent.data('locator'));

                // Update publish and last modified information from the server.
                this.model.fetch();
            },

            onNewXBlock: function(xblockElement, scrollOffset, data) {
                ViewUtils.setScrollOffset(xblockElement, scrollOffset);
                xblockElement.data('locator', data.locator);
                return this.refreshXBlock(xblockElement);
            },

            /**
             * Refreshes the specified xblock's display. If the xblock is an inline child of a
             * reorderable container then the element will be refreshed inline. If not, then the
             * parent container will be refreshed instead.
             * @param element An element representing the xblock to be refreshed.
             */
            refreshXBlock: function(element) {
                var xblockElement = this.findXBlockElement(element),
                    parentElement = xblockElement.parent(),
                    rootLocator = this.xblockView.model.id;
                if (xblockElement.length === 0 || xblockElement.data('locator') === rootLocator) {
                    this.render({refresh: true});
                } else if (parentElement.hasClass('reorderable-container')) {
                    this.refreshChildXBlock(xblockElement);
                } else {
                    this.refreshXBlock(this.findXBlockElement(parentElement));
                }
            },

            /**
             * Refresh an xblock element inline on the page, using the specified xblockInfo.
             * Note that the element is removed and replaced with the newly rendered xblock.
             * @param xblockElement The xblock element to be refreshed.
             * @returns {jQuery promise} A promise representing the complete operation.
             */
            refreshChildXBlock: function(xblockElement) {
                var self = this,
                    xblockInfo,
                    TemporaryXBlockView,
                    temporaryView;
                xblockInfo = new XBlockInfo({
                    id: xblockElement.data('locator')
                });
                // There is only one Backbone view created on the container page, which is
                // for the container xblock itself. Any child xblocks rendered inside the
                // container do not get a Backbone view. Thus, create a temporary view
                // to render the content, and then replace the original element with the result.
                TemporaryXBlockView = XBlockView.extend({
                    updateHtml: function(element, html) {
                        // Replace the element with the new HTML content, rather than adding
                        // it as child elements.
                        this.$el = $(html).replaceAll(element);
                    }
                });
                temporaryView = new TemporaryXBlockView({
                    model: xblockInfo,
                    view: 'reorderable_container_child_preview',
                    el: xblockElement
                });
                return temporaryView.render({
                    success: function() {
                        self.onXBlockRefresh(temporaryView);
                        temporaryView.unbind();  // Remove the temporary view
                    }
                });
            }
        });

        return XBlockContainerPage;
    }); // end define();
