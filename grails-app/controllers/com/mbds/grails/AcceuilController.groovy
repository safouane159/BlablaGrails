package com.mbds.grails

class AcceuilController {

    AnnonceService annonceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
       /* params.max = Math.min(max ?: 10, 100)
        respond annonceService.list(params), model:[annonceCount: annonceService.count()]*/

        def annonces = annonceService.list()

        return render(view: 'index', model: [annonces: annonces])
    }
    def details() {
        int idint = params.id as int
        def annonce = annonceService.get(idint)

        return render(view: 'details', model: [annonce: annonce])

    }

}
