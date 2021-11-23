//
//  ApplicationsModel.swift
//  CareerCrowder
//
//  Created by student on 11/21/21.
//

import CoreData

@objc(Applications)
class Applications: NSManagedObject
{
    @NSManaged var salary: String!
    @NSManaged var position: String!
    @NSManaged var name: String!
    @NSManaged var location: String!
    @NSManaged var jobStatus: String!
    @NSManaged var desc: String!
    @NSManaged var dateApp: Date!
    @NSManaged var appLink: String!
    
    
}
