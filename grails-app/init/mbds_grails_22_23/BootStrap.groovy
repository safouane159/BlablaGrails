package mbds_grails_22_23

import com.mbds.grails.Annonce
import com.mbds.grails.Illustration
import com.mbds.grails.Role
import com.mbds.grails.User
import com.mbds.grails.UserRole

class BootStrap {

    def init = { servletContext ->
        def adminUserInstance = new User(username: "admin",password: "admin",nomComplet : "Safouane synthesis thirty" ,tel : "0766398283", mail: "toto@gmail.com", aboutme: "i'am a seller please contact me ").save()
        def adminRole = new Role(authority: "ROLE_ADMIN").save()
        def clientUserInstance = new User(username: "client",password: "client",nomComplet : "Oussama synthesis thirty" ,tel : "0760398283", mail: "toeo@gmail.com", aboutme: "i'am ea seller please contact me ").save()
        def cleintRole = new Role(authority: "ROLE_CLIENT").save()

        UserRole.create(adminUserInstance, adminRole, true)
        UserRole.create(clientUserInstance, cleintRole, true)
        // On boucle sur une liste de 5 prénoms



        def userInstance = new User(username: "Alice", password: "password",nomComplet :"Alice synthesis thirty" ,tel : "0783647392" ,mail: "Alice@gmail.com", aboutme: "i'am Alice please contact ")
         def annonceInstanceAlice1 = new Annonce(title: "Magnifique piano roland digital rp 201 " , description: "Bonjour,\n" +
                "Piano comme neuf car très peu servi; uniquement 6  ...\n"
               , price: 790  , active: Boolean.TRUE,lng:7.2620 ,lat:43.7102,address:"Nice")

        annonceInstanceAlice1.addToIllustrations(new Illustration(filename: "a.jpeg"))
        annonceInstanceAlice1.addToIllustrations(new Illustration(filename: "a1.jpeg"))
        annonceInstanceAlice1.addToIllustrations(new Illustration(filename: "a2.jpeg"))
        annonceInstanceAlice1.addToIllustrations(new Illustration(filename: "a3.jpeg"))
        def annonceInstanceAlice = new Annonce(title:  " Piano Numérique Yamaha Clavinova CLP 930 " , description: "Je vend mon piano numérique Yamaha Clavinova CLP 930 avec son tabouret réglable.", price: 250, active: Boolean.TRUE,lng:7.2620 ,lat:43.7102,address:"Biot")

        annonceInstanceAlice.addToIllustrations(new Illustration(filename: "z.jpeg"))
        annonceInstanceAlice.addToIllustrations(new Illustration(filename: "z1.jpeg"))
        annonceInstanceAlice.addToIllustrations(new Illustration(filename: "z2.jpeg"))
        annonceInstanceAlice.addToIllustrations(new Illustration(filename: "z3.jpeg"))
        annonceInstanceAlice.addToIllustrations(new Illustration(filename: "z4.jpeg"))

        userInstance.addToAnnonces(annonceInstanceAlice)
        userInstance.addToAnnonces(annonceInstanceAlice1)
        // Et on sauvegarde l'utilisateur qui va sauvegarder ses annonces qui sauvegarderont leurs illustrations
        userInstance.save(flush: true, failOnError: true)

        UserRole.create(userInstance, cleintRole, true)

        def userInstance2 = new User(username: "Bob", password: "password",nomComplet :"Bob synthesis thirty" ,tel : "0783647392" ,mail: "Bob@gmail.com", aboutme: "i'am Bob please contact ")

        def annonceInstanceBob = new Annonce(title: "Canapé lité", description: "Canapé lit acheté chez Ubaldi il y a 2 ans\n" +
                "Matière: genre de cuir retourné\n" +
                "Couleur: beige\n", price: 350, active: Boolean.TRUE,lng:7.2620 ,lat:43.7102,address:"Avignon")

        def annonceInstanceBob1 = new Annonce(title: "Vend vélo d’appartement", description: "Vélo d’appartement\n" +
                "Très peu servi\n" +
                "Marque TOMAHAWK", price: 350, active: Boolean.TRUE,lng:7.2620 ,lat:43.7102,address:"Nice")
        annonceInstanceBob1.addToIllustrations(new Illustration(filename: "q.jpeg"))
        annonceInstanceBob1.addToIllustrations(new Illustration(filename: "q2.jpeg"))
        annonceInstanceBob1.addToIllustrations(new Illustration(filename: "q3.jpeg"))
        annonceInstanceBob1.addToIllustrations(new Illustration(filename: "q4.jpeg"))


        annonceInstanceBob.addToIllustrations(new Illustration(filename: "s.jpeg"))
        annonceInstanceBob.addToIllustrations(new Illustration(filename: "s1.jpeg"))
        annonceInstanceBob.addToIllustrations(new Illustration(filename: "s2.jpeg"))
        annonceInstanceBob.addToIllustrations(new Illustration(filename: "s3.jpeg"))

        userInstance2.addToAnnonces(annonceInstanceBob)
        userInstance2.addToAnnonces(annonceInstanceBob1)
        // Et on sauvegarde l'utilisateur qui va sauvegarder ses annonces qui sauvegarderont leurs illustrations
        userInstance2.save(flush: true, failOnError: true)
        UserRole.create(userInstance2, cleintRole, true)



    }
    def destroy = {

    }
}
