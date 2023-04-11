package com.mbds.grails

import grails.converters.JSON
import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap
import groovy.json.JsonSlurper
import org.grails.web.json.JSONArray
import sun.misc.BASE64Decoder

import java.awt.image.BufferedImage
import java.text.SimpleDateFormat
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

import static org.springframework.http.HttpStatus.NO_CONTENT

@Transactional
class AnnonceClassService {
    int patch(Annonce annoce, def obj) {

        if (obj.title) annoce.title = obj.title
        if (obj.description) annoce.description = obj.description
        if (obj.price) annoce.price = obj.price
        if (obj.active) annoce.active = obj.active
        if (obj.author) annoce.author = obj.author
        if (obj.lng) annoce.lng = Double.parseDouble(obj.lng);
        if (obj.lat) annoce.lat = Double.parseDouble(obj.lat);




        annoce.save(flush: true)
        return 200
    }

    def deleteIllustration(Annonce annonce) {

        annonce.illustrations.each {
            it.delete()
        }

        annonce.illustrations = null

        annonce.save(flush: true)


        return 200

    }

    int patchLocale(Annonce annoce, GrailsParameterMap params) {

        if (params.title) annoce.title = params.title
        if (params.description) annoce.description = params.description
        if (params.price) annoce.price = Double.parseDouble(params.price)
        if (params.active) annoce.active = params.active
        if (params.author) annoce.author = params.author
        if (params.lng) annoce.lng = Double.parseDouble(params.lng);
        if (params.lat) annoce.lat = Double.parseDouble(params.lat);
        if (params.address) annoce.address = params.address;



        if (params.Illustration) {

            User userInstance = User.findByUsername(params.username)

            def illustrationJSONParsed = JSON.parse(params.Illustration)

            List<String> illustrationList = new ArrayList<String>();
            for (int i = 0; i < illustrationJSONParsed.size(); i++) {
                illustrationList.add(illustrationJSONParsed.getString(i));
            }

            String[] illustrationArray = illustrationList.toArray(new String[illustrationList.size()]);



            if (illustrationArray) {


                if (illustrationArray.getClass().isArray()) {

                    for (int i; i < illustrationArray.size(); i++) {

                        def sourceData = illustrationArray[i]

                        MyPictureWritter wr = new MyPictureWritter()
                        String NameAndPathPicture = wr.wrtieAwS(sourceData)

                        def illustrationInstance = new Illustration(filename: NameAndPathPicture)
                        annoce.addToIllustrations(illustrationInstance)
                    }


                } else {


                    def sourceData = illustrationArray
                    MyPictureWritter wr = new MyPictureWritter()
                    String NameAndPathPicture = wr.wrtieAwS(sourceData)
                    def illustrationInstance = new Illustration(filename: NameAndPathPicture)
                    annoce.addToIllustrations(illustrationInstance)
                }
            }


        }

        annoce.save(flush: true)


        return 200

    }

    int Update(Annonce annoce, def obj) {


        if (!obj.title || !obj.description || !obj.username || !obj.price || !obj.active || !obj.lng || !obj.lat) {

            return 400
        } else {


            annoce.title = obj.title
            annoce.description = obj.description
            annoce.price = obj.price as Float
            annoce.active = obj.active
            annoce.author = User.findByUsername(obj.username)
            annoce.lng = obj.lng
            annoce.lat = obj.lat


            annoce.save(flush: true)
            return 200
        }

    }


    int UpdateLocale(Annonce annoce, GrailsParameterMap params) {


        if (!params.title || !params.description || !params.username || !params.price || !params.active || !params.lng || !params.lat) {

            return 400
        } else {


            annoce.title = params.title
            annoce.description = params.description
            annoce.price = params.price as Float
            annoce.active = params.active
            annoce.author = User.findByUsername(params.username)
            annoce.lng = Double.parseDouble(params.lng);
            annoce.lat = Double.parseDouble(params.lat);


            annoce.save(flush: true)
            return 200
        }

    }


    int addAnnonce(GrailsParameterMap params) {

        if (!params.title || !params.description || !params.price || !params.lng || !params.lat) {

            return 400
        } else if (!User.findByUsername(params.username)) {

            return 400
        } else {
            User userInstance = User.findByUsername(params.username)

            def annonceInstance = new Annonce(title: params.title, description: params.description, price: params.price
                    , address: params.address, author: userInstance, active: Boolean.TRUE, lng: Double.parseDouble(params.lng), lat: Double.parseDouble(params.lat))

            if (params.Illustration) {
                if (params.Illustration.getClass().isArray()) {

                    for (int i; i < params.Illustration.size(); i++) {

                        def sourceData = params.Illustration[i]
                        MyPictureWritter wr = new MyPictureWritter()
                        String NameAndPathPicture = wr.wrtieAwS(sourceData)
                        def illustrationInstance = new Illustration(filename: NameAndPathPicture)
                        annonceInstance.addToIllustrations(illustrationInstance)
                    }


                } else {

                    def sourceData = params.Illustration
                    MyPictureWritter wr = new MyPictureWritter()
                    String NameAndPathPicture = wr.wrtieAwS(sourceData)
                    def illustrationInstance = new Illustration(filename: NameAndPathPicture)
                    annonceInstance.addToIllustrations(illustrationInstance)
                }
            }

            userInstance.addToAnnonces(annonceInstance)
            userInstance.save(flush: true, failOnError: true)
            return 200
        }

    }


    int addAnnonceLocale(GrailsParameterMap params) {

        if (!params.title || !params.description || !params.price || !params.lng || !params.lat) {

            return 400
        } else if (!User.findByUsername(params.username)) {

            return 400
        } else {
            User userInstance = User.findByUsername(params.username)

            def annonceInstance = new Annonce(title: params.title, description: params.description, price: params.price
                    , address: params.address, author: userInstance, active: Boolean.TRUE, lng: Double.parseDouble(params.lng), lat: Double.parseDouble(params.lat))


            def illustrationJSONParsed = JSON.parse(params.Illustration)

            List<String> illustrationList = new ArrayList<String>();
            for (int i = 0; i < illustrationJSONParsed.size(); i++) {
                illustrationList.add(illustrationJSONParsed.getString(i));
            }

            String[] illustrationArray = illustrationList.toArray(new String[illustrationList.size()]);


            if (illustrationArray) {

                if (illustrationArray.getClass().isArray()) {

                    for (int i; i < illustrationArray.size(); i++) {

                        def sourceData = illustrationArray[i]
                        MyPictureWritter wr = new MyPictureWritter()
                        String NameAndPathPicture = wr.wrtieAwS(sourceData)
                        def illustrationInstance = new Illustration(filename: NameAndPathPicture)
                        annonceInstance.addToIllustrations(illustrationInstance)
                    }


                } else {

                    def sourceData = illustrationArray
                    MyPictureWritter wr = new MyPictureWritter()
                    String NameAndPathPicture = wr.wrtieAwS(sourceData)
                    def illustrationInstance = new Illustration(filename: NameAndPathPicture)
                    annonceInstance.addToIllustrations(illustrationInstance)
                }
            }

            userInstance.addToAnnonces(annonceInstance)
            userInstance.save(flush: true, failOnError: true)
            def d = Annonce.findByTitle(annonceInstance.title)

            return d.id
        }

    }


}

