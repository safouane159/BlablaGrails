package com.mbds.grails

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap
import org.grails.web.servlet.GrailsRequestContext

@Transactional
class UserClassService {

    int Update(User user, def obj) {

        if (!obj.password || !obj.username || !obj.tel || !obj.nomComplet || !obj.mail || !obj.aboutme) {

            return 400
        } else {

            user.password = obj.password
            user.username = obj.username
            user.nomComplet = obj.nomComplet
            user.tel = obj.tel
            user.mail = obj.mail
            user.aboutme = obj.aboutme
            user.save(flush: true)
            return 200
        }

    }
    int UpdateLocale(User user, GrailsParameterMap params) {

        if (!params.password || !params.username || !params.tel || !params.nomComplet || !params.mail || !params.aboutme) {

            return 400
        } else {

            user.password = params.password
            user.username = params.username
            user.nomComplet = params.nomComplet
            user.tel = params.tel
            user.mail = params.mail
            user.aboutme = params.aboutme
            user.save(flush: true)
            return 200
        }

    }

    int patch(User user, def obj) {

        if (obj.mail) user.mail = obj.mail
        if (obj.aboutme) user.aboutme = obj.aboutme
        if (obj.password) user.password = obj.password
        if (obj.username) user.username = obj.username
        if (obj.tel) user.tel = obj.tel
        if (obj.nomComplet) user.nomComplet = obj.nomComplet
        if (obj.enabled) (user.enabled = true) else (user.enabled = false)


        if (obj.role) {
            if ((obj.role).equals("admin")) {
                Role role_admin = Role.findByAuthority("ROLE_ADMIN")
                Role role_client = Role.findByAuthority("ROLE_CLIENT")
                UserRole.remove user, role_client
                UserRole.create user, role_admin
                user.save(flush: true)

            } else {
                Role role_admin = Role.findByAuthority("ROLE_ADMIN")
                Role role_client = Role.findByAuthority("ROLE_CLIENT")
                UserRole.remove user, role_admin
                UserRole.create user, role_client
                user.save(flush: true)
            }

        }

        user.save(flush: true)
        return 200


    }

    int patchLocale(User user, GrailsParameterMap params) {

        if (params.mail) user.mail = params.mail
        if (params.aboutme) user.aboutme = params.aboutme
        if (params.password) user.password = params.password
        if (params.username) user.username = params.username
        if (params.tel) user.tel = params.tel
        if (params.nomComplet) user.nomComplet = params.nomComplet
        if (params.enabled) (user.enabled = true) else (user.enabled = false)


        if (params.role) {
            if ((params.role).equals("admin")) {
                Role role_admin = Role.findByAuthority("ROLE_ADMIN")
                Role role_client = Role.findByAuthority("ROLE_CLIENT")
                UserRole.remove user, role_client
                UserRole.create user, role_admin
                user.save(flush: true)

            } else {
                Role role_admin = Role.findByAuthority("ROLE_ADMIN")
                Role role_client = Role.findByAuthority("ROLE_CLIENT")
                UserRole.remove user, role_admin
                UserRole.create user, role_client
                user.save(flush: true)
            }

        }


        System.out.println(params.enabled)
        user.save(flush: true)
        return 200


    }

    int addUser(GrailsParameterMap params) {

        if (!params.password || !params.username || !params.mail || !params.nomComplet || !params.tel || !params.aboutme) {

            return 400
        } else if (User.findByUsername(params.username)) {
            return 400
        } else {
            def userInstance = new User(username: params.username, password: params.password, nomComplet: params.nomComplet, tel: params.tel, mail: params.mail, aboutme: params.aboutme)
            userInstance.save(flush: true)
            return 200
        }

    }

    int addUserLocale(GrailsParameterMap params) {

        if (!params.password || !params.username || !params.mail || !params.nomComplet || !params.tel || !params.aboutme) {

            return 400
        } else if (User.findByUsername(params.username)) {
            return 400
        } else {
            def userInstance = new User(username: params.username, password: params.password, nomComplet: params.nomComplet, tel: params.tel, mail: params.mail, aboutme: params.aboutme)
            userInstance.save(flush: true)
            return 200
        }

    }


}
