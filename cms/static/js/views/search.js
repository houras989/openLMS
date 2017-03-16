(function(define) { 
    'use strict';

    define([
        'underscore',
        'backbone',
        'edx-ui-toolkit/js/utils/html-utils',
        'edx-ui-toolkit/js/utils/constants',
        'text!templates/search.underscore'
    ],
    function(_, Backbone, HtmlUtils, constants, searchTemplate) {
        /*
         * TODO: Much of the actual search functionality still takes place in discussion_thread_list_view.js
         * Because of how it's structured there, extracting it is a massive task. Significant refactoring is needed
         * in order to clean up that file and make it possible to break its logic into files like this one.
         */
        var searchView = Backbone.View.extend({
            events: {
                    'click .search-button': 'searchKey',
                    'click .cancel-button': 'cancelSearch'
            },

            initialize: function(options) {
                this.template = HtmlUtils.template(searchTemplate);
            },

            render: function() {
                HtmlUtils.setHtml(this.$el, this.template());
                return this;
            },

            searchKey: function() {
                var searchKey = this.$('.search-field').val();
                this.collection.setSearchKey(searchKey);
                this.collection.setPage(1);
            },

            cancelSearch: function() {
                this.$('.search-field').val('');
                this.collection.setSearchKey('');
                this.collection.setPage(1);
            }
        });

        return searchView;
    });
}).call(this, define || RequireJS.define);