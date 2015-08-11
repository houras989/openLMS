;(function (define) {
    'use strict';
    define(['common/js/components/collections/paging_collection', 'teams/js/models/team_membership'],
        function(PagingCollection, TeamMembershipModel) {
            var TeamMembershipCollection = PagingCollection.extend({
                initialize: function(team_memberships, options) {
                    PagingCollection.prototype.initialize.call(this);

                    this.course_id = options.course_id;
                    this.username = options.username;
                    this.privileged = options.privileged;
                    this.allowMultipleTeamMembership = options.allowMultipleTeamMembership;
                    this.perPage = options.per_page || 10;
                    this.server_api['expand'] = 'team';
                    this.server_api['course_id'] = function () { return encodeURIComponent(options.course_id); };
                    this.server_api['username'] = this.username;
                    delete this.server_api['sort_order']; // Sort order is not specified for the TeamMembership API
                    delete this.server_api['order_by']; // Order by is not specified for the TeamMembership API
                },

                model: TeamMembershipModel,

                canUserCreateTeam: function() {
                    // Note: non-privileged users are automatically added to any team
                    // that they create. This means that if multiple team membership is
                    // disabled that they cannot create a new team when they already
                    // belong to one.
                    return this.privileged || this.allowMultipleTeamMembership || this.length === 0;
                }
            });
            return TeamMembershipCollection;
    });
}).call(this, define || RequireJS.define);
