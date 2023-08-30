package com.NTMG.Geldverwalten.Controller;

import com.NTMG.Geldverwalten.Model.*;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;


@RestController
public class controller {

    BaseDeDonnee bd = new BaseDeDonnee();

/*
    // creation d'un projet
    @RequestMapping(value = "/createProjet", method = RequestMethod.POST, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object createProjet(@RequestHeader("authorization") String token,@RequestBody Projet projet, HttpServletResponse response) throws SQLException{

        projet.setIdUser(bd.getUserByToken(token).getId());
            int result = bd.ajoutProjet(projet);

            if(result==1){
                response.setStatus(400);
                return new ApiError(400,"une erreur est survenu","bad request");
            }else{
                return result;
            }

    }
    // ajout nouvelle entree
    @RequestMapping(value = "/addEntree", method = RequestMethod.POST, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object addEntree(@RequestHeader("authorization") String token, @RequestBody DEntres dEntres, HttpServletResponse response) throws SQLException{

        System.out.println("eeeeeeeeeeeeeeee");
        dEntres.setIdUser(bd.getUserByToken(token).getId());
        int result = bd.ajoutEntre(dEntres);

        if(result==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // ajout nouvelle sortie
    @RequestMapping(value = "/addSortie/{id}", method = RequestMethod.POST, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object addSortie(@RequestHeader("authorization") String token,@PathVariable("id") int id, @RequestBody DSortie dSortie, HttpServletResponse response) throws SQLException{


        dSortie.setIdProjet(id);
        int result = bd.ajoutSorti(dSortie);

        if(result==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // nombre de projet en cours
    @RequestMapping(value = "/nbProjet", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object nbProjet(@RequestHeader("authorization") String token, HttpServletResponse response) throws SQLException{

        int result = bd.countProjet();

            return result;

    }
    // modifier une sortie
    @RequestMapping(value = "/updateSortie/{id}", method = RequestMethod.PUT, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object updateSortie(@RequestHeader("authorization") String token, @PathVariable("id") int id,@RequestBody DSortie dSortie, HttpServletResponse response) throws SQLException{


        dSortie.setId(id);
        int result = bd.modifsortie(dSortie);

        if(result==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    //supprimer un projet
    @RequestMapping(value = "/deleteProjet/{id}", method = RequestMethod.DELETE, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object deleteProjet(@RequestHeader("authorization") String token, @PathVariable("id") int id, HttpServletResponse response){

        int result = bd.supprojet(id);

        if(result==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // Mon solde
    @RequestMapping(value = "/solde", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object solde(@RequestHeader("authorization") String token, HttpServletResponse response) throws SQLException{

        int result = bd.bilan();

        if(result==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // toutes les entrees
    @RequestMapping(value = "/getEntree", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object getEntree(@RequestHeader("authorization") String token, HttpServletResponse response) throws SQLException{

        List result = bd.recherchee();

        if(result.isEmpty()){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // toutes les sorties
    @RequestMapping(value = "/getSortie", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object getSortie(@RequestHeader("authorization") String token, HttpServletResponse response) throws SQLException{

        List result = bd.recherches();

        if(result.isEmpty()){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // toutes les sorties d'un projet
    @RequestMapping(value = "/getProjet/{id}", method = RequestMethod.POST, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object getProjet(@RequestHeader("authorization") String token,@PathVariable("id") int id, HttpServletResponse response) throws SQLException{

        System.out.println("eeee "+id);
        List result = bd.recherchesproj(id);

        if(result.isEmpty()){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }


*/
    // creation d'un projet
    @RequestMapping(value = "/createProjet", method = RequestMethod.POST, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object createProjet(@RequestBody Projet projet, HttpServletResponse response) throws SQLException{

        projet.setIdUser(1);
            int result = bd.ajoutProjet(projet);

            if(result==1){
                response.setStatus(400);
                return new ApiError(400,"une erreur est survenu","bad request");
            }else{
                return result;
            }

    }
    // ajout nouvelle entree
    @RequestMapping(value = "/addEntree", method = RequestMethod.POST, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object addEntree(@RequestBody DEntres dEntres, HttpServletResponse response) throws SQLException{

        System.out.println("eeeeeeeeeeeeeeee");
        dEntres.setIdUser(1);
        int result = bd.ajoutEntre(dEntres);

        if(result==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // ajout nouvelle sortie
    @RequestMapping(value = "/addSortie/{id}", method = RequestMethod.POST, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object addSortie(@PathVariable("id") int id, @RequestBody DSortie dSortie, HttpServletResponse response) throws SQLException{


        dSortie.setIdProjet(id);
        int result = bd.ajoutSorti(dSortie);

        if(result==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // nombre de date des sorties
    @RequestMapping(value = "/nbProjet", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object nbDate(HttpServletResponse response) throws SQLException{

        List result = bd.countProjet();

            return result;

    }
    // modifier une sortie
    @RequestMapping(value = "/updateSortie/{id}", method = RequestMethod.PUT, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object updateSortie( @PathVariable("id") int id,@RequestBody DSortie dSortie, HttpServletResponse response) throws SQLException{


        dSortie.setId(id);
        int result = bd.modifsortie(dSortie);

        if(result==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    //supprimer un projet
    @RequestMapping(value = "/deleteProjet/{id}", method = RequestMethod.DELETE, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object deleteProjet( @PathVariable("id") int id, HttpServletResponse response){

        int result = bd.supprojet(id);

        if(result==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // Mon solde
    @RequestMapping(value = "/solde", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object solde(HttpServletResponse response) throws SQLException{

        solde result = bd.bilan();

        if(result.getMontant()==1){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // toutes les entrees
    @RequestMapping(value = "/getEntree", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object getEntree(HttpServletResponse response) throws SQLException{

        List result = bd.recherchee();

        if(result.isEmpty()){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // toutes les sorties
    @RequestMapping(value = "/getSortie", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object getSortie( HttpServletResponse response) throws SQLException{

        List result = bd.recherches();

        if(result.isEmpty()){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }
    // toutes les sorties d'un projet
    @RequestMapping(value = "/getProjet/{id}", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object getProjet(@PathVariable("id") int id, HttpServletResponse response) throws SQLException{

        System.out.println("eeee "+id);
        List result = bd.recherchesproj(id);

            return result;

    }
    // tous les projets
    @RequestMapping(value = "/getProjets", method = RequestMethod.GET, consumes= MediaType.APPLICATION_JSON_VALUE)
    public Object getProjets(HttpServletResponse response) throws SQLException{

        List result = bd.listeProjets();

        if(result.isEmpty()){
            response.setStatus(400);
            return new ApiError(400,"une erreur est survenu","bad request");
        }else{
            return result;
        }

    }




}


