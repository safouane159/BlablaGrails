package com.mbds.grails

import grails.converters.JSON
import grails.converters.XML
import grails.plugin.springsecurity.annotation.Secured

import java.sql.SQLOutput

@Secured('ROLE_ADMIN')
class ApiController {

    /**
     * Singleton
     * Gestion des points d'entrée : GET / PUT / PATCH / DELETE
     */
    UserService userService
    UserClassService userClassService

    AnnonceService annonceService
    AnnonceClassService annonceClassService

    def annonce() {
        // On vérifie qu'un ID ait bien été fourni
        if (!params.id)
            return response.status = 400
        // On vérifie que l'id corresponde bien à une instance existante
        def annonceInstance = annonceService.get(params.id)
        if (!annonceInstance)
            return response.status = 404

        switch (request.getMethod()) {

            case "GET":
                renderThis(request.getHeader("Accept"), annonceInstance)
                break;

            case "PUT":
                def jsonobjAnnocePut = JSON.parse(request);
                int result = annonceClassService.Update(annonceInstance, jsonobjAnnocePut)
                return response.status = result
                break;

            case "PATCH":
                def jsonobjAnnocePatch = JSON.parse(request);
                int result = annonceClassService.patch(annonceInstance, jsonobjAnnocePatch)
                return response.status = result
                break;
            case "DELETE":
                annonceInstance.delete(flush: true)
                return response.status = 200
                break;
            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }

    /**
     * Collection
     * POST / GET
     */
    def annonces() {

        def annonces = annonceService.list()


        switch (request.getMethod()) {

            case "GET":
                renderThis(request.getHeader("Accept"), annonces)
                break;

            case "POST":

                int result = annonceClassService.addAnnonce(params)
                return response.status = result
                break;

            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }

    def user() {
        // On vérifie qu'un ID ait bien été fourni
        if (!params.id)
            return response.status = 400
        // On vérifie que l'id corresponde bien à une instance existante
        def UserInstance = userService.get(params.id)
        if (!UserInstance)
            return response.status = 404

        switch (request.getMethod()) {

            case "GET":
                renderThis(request.getHeader("Accept"), UserInstance)
                break;

            case "PUT":
                def jsonobj1 = JSON.parse(request);
                int result = userClassService.Update(UserInstance, jsonobj1)
                return response.status = result
                break;
            case "PATCH":
                def jsonobj = JSON.parse(request);
                int result = userClassService.patch(UserInstance, jsonobj)
                return response.status = result
                break;
            case "DELETE":
                UserInstance.delete(flush: true)
                return response.status = 200
                break;
            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }

    def users() {

        def users = userService.list()


        switch (request.getMethod()) {

            case "GET":
                renderThis(request.getHeader("Accept"), users)
                break;

            case "POST":
                int result = userClassService.addUser(params)
                return response.status = result
                break;

            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }

    def renderThis(String acceptHeader, Object object) {
        switch (acceptHeader) {
            case 'xml':
            case 'text/xml':
            case 'application/xml':
                render object as XML
                break;
            case 'json':
            case 'text/json':
            case 'application/json':
                render object as JSON
                break;
        }
    }
}
