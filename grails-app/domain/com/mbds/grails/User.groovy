package com.mbds.grails

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes = 'username')
@ToString(includes = 'username', includeNames = true, includePackage = false)
class User implements Serializable {

    private static final long serialVersionUID = 1

    String username
    String password
    String nomComplet
    boolean enabled = true
    String tel
    String mail
    String aboutme


    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    static hasMany = [annonces: Annonce]

    Set<Role> getAuthorities() {
        (UserRole.findAllByUser(this) as List<UserRole>)*.role as Set<Role>
    }

    static constraints = {
        password nullable: false, blank: false, password: true
        username nullable: false, blank: false, unique: true
        tel nullable: false, blank: false
        mail nullable: false, blank: false, email: true
        aboutme nullable: false, blank: false
        nomComplet nullable: false, blank: false


    }

    static mapping = {
        password column: '`password`'

    }
}
