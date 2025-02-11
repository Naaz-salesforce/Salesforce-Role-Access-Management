trigger AssignRolePermissions on User (after insert, after update) {
    for (User usr : Trigger.new) {
        RoleBasedAccessManager.assignRolePermissions(usr);
    }
}
