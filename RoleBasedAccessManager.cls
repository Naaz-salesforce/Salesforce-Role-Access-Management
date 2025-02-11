public class RoleBasedAccessManager {
    public static void assignRolePermissions(User usr) {
        List<RolePermission__mdt> rolePermissions = [SELECT Role_Name__c, Permission_Set_Name__c FROM RolePermission__mdt WHERE Role_Name__c = :usr.UserRole.Name];

        List<PermissionSetAssignment> assignments = new List<PermissionSetAssignment>();
        for (RolePermission__mdt rp : rolePermissions) {
            PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = :rp.Permission_Set_Name__c LIMIT 1];
            
            PermissionSetAssignment psa = new PermissionSetAssignment(
                AssigneeId = usr.Id,
                PermissionSetId = ps.Id
            );
            assignments.add(psa);
        }
        if (!assignments.isEmpty()) {
            insert assignments;
        }
    }
}
