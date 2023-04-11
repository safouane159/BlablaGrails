package com.mbds.grails

class Annonce {

    String title
    String description
    String address
    Float price
    Boolean active = Boolean.FALSE
    double lng
    double lat
    Date dateCreated
    Date lastUpdated

    static belongsTo = [author: User]

    static hasMany = [illustrations: Illustration]

    static mapping = {
        illustrations cascade: 'all'
    }

    static constraints = {
        title blank: false, nullable: false, size: 5..100
        description blank: false, nullable: false
        address blank: false, nullable: false
        price scale: 2, min: 0F, nullable: false
        active nullable: false
    }
}
