;(function (define) {
    'use strict';
    define(['teams/js/collections/team'], function (TeamCollection) {
        var MyTeamsCollection = TeamCollection.extend({
            initialize: function (teams, options) {
                if (options.url) {
                    this.url = options.url;
                }
                TeamCollection.prototype.initialize.call(this, teams, options);
                delete this.server_api.topic_id;
                this.server_api = _.extend(this.server_api, {
                    username: options.username
                });
            }
        });
        return MyTeamsCollection;
    });
}).call(this, define || RequireJS.define);
