package com.mbds.grails

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured

import static java.lang.Integer.parseInt

class AdminController {

    UserService userService
    UserClassService userClassService
    AnnonceClassService annonceClassService
    SpringSecurityService springSecurityService
    AnnonceService annonceService

    def index() {}

    @Secured("ROLE_ADMIN")
    def dashboard() {

        def count_users = userService.count()
        def count_annonces = annonceService.count()

        return render(view: 'dashboard', model: [count_users: count_users, count_annonces: count_annonces])
    }

    @Secured("ROLE_ADMIN")
    def users() {

        def users = userService.list()

        return render(view: 'users', model: [users: users])
    }


    @Secured(["ROLE_ADMIN", "ROLE_CLIENT"])
    def annonces() {
        def role = principal.authorities*.authority
        def annonces
        if (role.contains("ROLE_ADMIN")) {
            annonces = annonceService.list()
        } else if (role.contains("ROLE_CLIENT")) {
            annonces = User.findByUsername(springSecurityService.currentUser.username).annonces
        }


        return render(view: 'annonces', model: [annonces: annonces])
    }


    @Secured("ROLE_ADMIN")
    def listUsers() {
        def users = userService.list()

        response users
    }

    @Secured("ROLE_ADMIN")
    def createUser() {

        //CREATE
        if (parseInt(params.id) == 0) {
            def userInstance = new User(
                    username: params.username,
                    password: params.password,
                    mail: params.mail,
                    nomComplet: params.nomComplet,
                    tel: params.tel,
                    aboutme: params.aboutme,
                    enabled: (params.enabled) ? true : false
            ).save(flush: true)

            def userRole = Role.findByAuthority("ROLE_CLIENT")
            if (params.role == "admin") {
                userRole = Role.findByAuthority("ROLE_ADMIN")
            }

            UserRole.create(userInstance, userRole, true)
        } else {
            //UPDATE
            def userInstance = User.get(params.id)

            int result = userClassService.patch(userInstance, params)
            System.out.println(result)


        }


        this.users()
    }

    @Secured(["ROLE_ADMIN", "ROLE_CLIENT"])
    def deleteAllIllustrations() {
        def annonce = Annonce.get(params.id)
        annonceClassService.deleteIllustration(annonce)
        render 200
    }

    @Secured(["ROLE_ADMIN", "ROLE_CLIENT"])
    def createAnnonce() {

        //CREATE
        System.out.println(params.id)
        if (parseInt(params.id) == 0) {

            User userInstance = User.get(params.user)
            params.username = userInstance.username
            def idA = annonceClassService.addAnnonceLocale(params)


            render idA
        } else {
            def annonce = Annonce.get(params.id)
            User userInstance = User.get(params.user)
            params.username = userInstance.username

            annonceClassService.patchLocale(annonce, params)

            render 200

        }


    }


    @Secured(["ROLE_ADMIN"])
    def form_user_admin(int id) {
        def user = null
        def user_is_admin = false

        if (id > 0) {
            user = userService.get(id)
            user_is_admin = UserRole.exists(user.id, Role.findByAuthority("ROLE_ADMIN").getId())
        }
        return render(view: 'form_user', model: [user: user, user_is_admin: user_is_admin])
    }

    @Secured(["ROLE_ADMIN", "ROLE_CLIENT"])
    def form_annonce_admin(int id) {
        def annonce = null
        def role = principal.authorities*.authority
        def users
        if (role.contains("ROLE_ADMIN")) {
            users = userService.list()
        } else if (role.contains("ROLE_CLIENT")) {
            users = User.findByUsername(springSecurityService.currentUser.username)
        }


        if (id > 0) {
            annonce = annonceService.get(id)
        }
        return render(view: 'form_annonce', model: [annonce: annonce, users: users])
    }

}
