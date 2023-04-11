
package com.mbds.grails

import com.amazonaws.AmazonServiceException
import com.amazonaws.SdkClientException
import com.amazonaws.services.s3.AmazonS3
import com.amazonaws.services.s3.AmazonS3Client
import com.amazonaws.services.s3.model.CannedAccessControlList
import com.amazonaws.services.s3.model.ObjectMetadata
import com.amazonaws.services.s3.model.PutObjectRequest
import grails.web.servlet.mvc.GrailsParameterMap
import sun.misc.BASE64Decoder

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter


class MyPictureWritter {

    def amazonS3Service
    String clientRegion = "eu-west-3";
    String bucketName = "blablagrails";
    String path = "illustration/";



    String wrtieAwS(def pictureBase64){


        try {
        def parts = pictureBase64.tokenize(",");

        def imageString = parts[1];

        String type = parts[0].toString().replace("data:image/", "").replace(";base64", "")

        BASE64Decoder decoder = new BASE64Decoder();
        byte[] imageByte = decoder.decodeBuffer(imageString);

        InputStream fis = new ByteArrayInputStream(imageByte);

        String keyName = "ill"+getDateNow()  + "image." + type;
        String keyFullName = path+keyName;

        AmazonS3 s3 = new AmazonS3Client();


        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(imageByte.length);
        metadata.setContentType(type);
        metadata.setCacheControl("public, max-age=31536000");


        s3.putObject(
                new PutObjectRequest(bucketName, keyFullName, fis, metadata)
                        .withCannedAcl(CannedAccessControlList.PublicReadWrite));


            System.out.println("Object upload complete");
            return keyName
        } catch (AmazonServiceException e) {
            // The call was transmitted successfully, but Amazon S3 couldn't process
            // it, so it returned an error response.
            e.printStackTrace();
        } catch (SdkClientException e) {
            // Amazon S3 couldn't be contacted for a response, or the client
            // couldn't parse the response from Amazon S3.
            e.printStackTrace();
        }



    }


    def deleteFile(def filekey) {
        String keyFullName = path+filekey;
        def found = amazonS3Service.exists('blablagrails',keyFullName)
        if(found) {
            amazonS3Service.deleteFile('blablagrails', keyFullName)
            System.out.println("File "+keyFullName+" deleted")

        }
    }




























    MyPictureWritter() {

    }


    String wrtie(def sourceData, String user,String annonce) {

        // def sourceData = params.myimage
        def parts = sourceData.tokenize(",");
        def imageString = parts[1];

        String type = parts[0].toString().replace("data:image/", "").replace(";base64", "")

        byte[] imageByte;

        BASE64Decoder decoder = new BASE64Decoder();
        imageByte = decoder.decodeBuffer(imageString);

        String pathFileToreturn = user+annonce +getDateNow()  + "image." + type;
        String pathFileToWrite  = "grails-app/assets/images/illustrations/"+pathFileToreturn;

        new File(pathFileToWrite).withOutputStream {
            it.write(imageByte);
        }
        return pathFileToreturn
    }


    String getDateNow() {


        LocalDateTime now = LocalDateTime.now()
        DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;
        String formattedDateTime = now.format(formatter);

        return formattedDateTime

    }

}
