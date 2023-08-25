package com.NTMG.Geldverwalten.Model;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;

public class BaseDeDonnee {



    private static DEntres entres;
    private static DSortie sortie;

    //public static ArrayList<String> listedesprojets = new ArrayList<>();
    //private static ArrayList<String> listedesdates = new ArrayList<>();
    //private static ArrayList<String> listedesdate = new ArrayList<>();
    //public static int nombredeprojet=0;
    //private static int nombrededates=0;
    //private static int nombrededate=0;
    //private static int nombredesorties=0;
    //private static int nombredentres=0;




    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();


    public int Add_Membre(user newMembre){


        int rep=0,cnt=0;
        cnt=verif_double(newMembre.getEmail());


        System.out.println("le mot de passe : "+newMembre.getMotdepasse());
        String encryptPws = passwordEncoder.encode(newMembre.getMotdepasse());


        LocalDateTime date = LocalDateTime.now();

        if(cnt==0){
            try{
                String query="INSERT INTO `user`(`nom`, `prenom`, `pseudo`, `email`, `password`, `token`) VALUES  (?,?,?,?,?,?)";
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");
                PreparedStatement pst=con.prepareStatement(query);

                pst.setString(1, newMembre.getNom());
                pst.setString(2, newMembre.getPrenom());
                pst.setString(3, newMembre.getPseudo());
                pst.setString(4, newMembre.getEmail());
                pst.setString(5, encryptPws);
                pst.setString(6,newMembre.getToken());


                pst.executeUpdate();


                System.out.println("register successfully");
                rep=1;

            }
            catch (Exception exc){
                System.out.println(exc);
            }

            if(rep==1){

                return 1;
            }else{
                return 0;
            }
        }else{
            System.out.println("this member alrady exist");

            return 0;
        }


    }
    public int verif_double(String login ){

        int h=0;

        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT `email` FROM `user` WHERE `email`='"+login+"'");



            while(rs.next()){
                h=h+1;
            }

        }
        catch (Exception exc){
            System.out.println(exc);
        }

        if(h==0){
            return 0;
        }else{
            return 1;
        }

    }

    public user searchUser(String email ){

        String passWord="",mail="";
        user membre = new user();


        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/synes_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM `user` WHERE `email`='"+email+"'");



            while(rs.next()){
                membre.setNom(rs.getString("nom"));
                membre.setPrenom(rs.getString("prenom"));
                membre.setEmail(rs.getString("email"));
                membre.setPseudo(rs.getString("pseudo"));
                membre.setMotdepasse(rs.getString("password"));


                System.out.println(membre);
            }

        }
        catch (Exception exc){
            System.out.println(exc+"  error connect");
        }
        System.out.println("  MemberConn well connect");

        return membre;

    }

    public int verif_Membre(String email ,String pws ){

        String mail="",encryptedPws="";


        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT `password`,`email` FROM `user` WHERE `email`='"+email+"'");



            while(rs.next()){
                encryptedPws=rs.getString("password");
                mail=rs.getString("email");
                System.out.println(pws+" = "+encryptedPws+" "+mail);
            }

        }
        catch (Exception exc){
            System.out.println(exc+"  error connect");
        }

        if(passwordEncoder.matches(pws,encryptedPws)){
            System.out.println("  Member well connect");
            return 1;
        }else{
            System.out.println(mail+" :fff: "+pws+" != "+encryptedPws+" :even the mail adress or the password is wrong");
            return 0;
        }

    }


    public user verif_email(String email ){

        String passWord="",mail="";
        user user = null;


        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT `password`,`email` FROM `user` WHERE `email`='"+email+"'");



            while(rs.next()){
                passWord=rs.getString("password");
                mail=rs.getString("email");
                System.out.println(passWord+" "+mail);
            }
            user = new user(mail,passWord);

        }
        catch (Exception exc){
            System.out.println(exc+"  error connect");
        }
        System.out.println("  MemberConn well connect");

        return user;

    }


    public int ajoutEntre(DEntres entres) throws SQLException{

        int rep=0,cnt=0;

        LocalDateTime date = LocalDateTime.now();
        System.out.println(date);


        if(cnt==0){
            try{
                String query="INSERT INTO `dentres` (`date`,`message`,`montant`,`idUser`) VALUES (?,?,?,?)";
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");
                PreparedStatement pst=con.prepareStatement(query);

                pst.setObject(1, date);
                pst.setString(2, entres.getMessage());
                pst.setInt(3, entres.getMontant());
                pst.setInt(4, entres.getIdUser());

                pst.executeUpdate();


                System.out.println("register successfully");
                rep=1;

            }
            catch (Exception exc){
                System.out.println(exc);
            }

            if(rep==1){

                return 0;
            }else{
                return 1;
            }
        }else{
            System.out.println("this university alrady exist");

            return 1;
        }


    }//ok

    public int ajoutSorti(DSortie sortie) throws SQLException{

        int rep=0,cnt=0;


        LocalDateTime date = LocalDateTime.now();

        String valfs="               [S] "+sortie.getMessage()+" : "+sortie.getMontant()+" FCFA"  ;
        System.out.println(valfs);


            try{
                String query="INSERT INTO `dsortie` (`date`,`idProjet`,`message`,`montant`,`valeur`) VALUES (?,?,?,?,?)";
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");
                PreparedStatement pst=con.prepareStatement(query);

                pst.setObject(1, date);
                pst.setInt(2, sortie.getIdProjet());
                pst.setString(3, sortie.getMessage());
                pst.setInt(4, sortie.getMontant());
                pst.setString(5, valfs);

                pst.executeUpdate();


                System.out.println("register successfully");
                rep=1;

            }
            catch (Exception exc){
                System.out.println(exc);
            }

            if(rep==1){

                return 0;
            }else{
                return 1;
            }

    }//ok

    public int ajoutProjet(Projet projet) throws SQLException{

        int rep=0,cnt=0;
        cnt = verif_double_projet(projet.getNomProjet());


        if(cnt==0){
            try{
                String query="INSERT INTO `dprojet` (`statut`,`nomprojet`,`idUser`) VALUES (?,?,?)";
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");
                PreparedStatement pst=con.prepareStatement(query);

                pst.setInt(1, 1);
                pst.setString(2, projet.getNomProjet());
                pst.setInt(3, projet.getIdUser());

                pst.executeUpdate();


                System.out.println("register successfully");
                rep=1;

            }
            catch (Exception exc){
                System.out.println(exc);
            }

            if(rep==1){

                return 0;
            }else{
                return 1;
            }
        }else{
            System.out.println("this projet alrady exist");

            return 1;
        }

    }//ok
    public int verif_double_projet(String nom ){

        int h=0;

        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT `nomprojet` FROM `dprojet` WHERE `nomprojet`='"+nom+"'");



            while(rs.next()){
                h=h+1;
            }

        }
        catch (Exception exc){
            System.out.println(exc);
        }

        if(h==0){
            return 0;
        }else{
            return 1;
        }

    }

    public int countProjet() throws SQLException{


        int h=0;

        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM `dprojet`");



            while(rs.next()){
                h=h+1;
            }

        }
        catch (Exception exc){
            System.out.println(exc);
        }

        return h;
    }//ok

    public int modifsortie(DSortie sortie) throws SQLException{

        int rep=0,cnt=0;

        String valfs="               [S] "+sortie.getMessage()+" : "+sortie.getMontant()+" FCFA"  ;
        System.out.println(valfs);


            try{
                String query="UPDATE `dsortie` SET `message`=?,`montant`=?,`valeur`=? WHERE `id`=? ";
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");
                PreparedStatement pst=con.prepareStatement(query);

                pst.setString(1, sortie.getMessage());
                pst.setInt(2, sortie.getMontant());
                pst.setString(3, valfs);
                pst.setInt(4, sortie.getId());

                pst.executeUpdate();


                System.out.println("successfully updated");
                rep=1;

            }
            catch (Exception exc){
                System.out.println(exc);
            }

            if(rep==1){
                return 0;
            }else{
                return 1;
            }


    }//ok

    public int supprojet(int id) {

        int rep=0;


        try{
            String query="DELETE FROM `dsortie` WHERE `idProjet` =?";
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");
            PreparedStatement pst=con.prepareStatement(query);
            pst.setInt(1, id);
            pst.executeUpdate();
            System.out.println("successfully deleted ");


            String query1="DELETE FROM `dprojet` WHERE `id` =?";
            PreparedStatement pst1=con.prepareStatement(query1);
            pst1.setInt(1, id);
            pst1.executeUpdate();
            System.out.println("successfully deleted ");

            rep=1;

        }
        catch (Exception exc){
            System.out.println(exc);
        }

        if(rep==1){
            return 0;
        }else{
            return 1;
        }

    }//ok

    public int bilan() throws SQLException{



        int h=0,h1=0,h2=0;

        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM `dentres`");

            while(rs.next()){
                h1 =h1+ rs.getInt("montant");
            }



            Statement stmt1 = con.createStatement();

            ResultSet rs1 = stmt1.executeQuery("SELECT * FROM `dsortie`");

            while(rs1.next()){
                h2 =h2+ rs1.getInt("montant");
            }

        }
        catch (Exception exc){
            System.out.println(exc);
        }
        h=h1-h2;
        return h;

    }//ok



    public ArrayList<DEntres> recherchee() {

        ArrayList<String> listedesdate = new ArrayList<>();
        ArrayList<String> lists = new ArrayList<String>();
        ArrayList<DEntres> listedesentres = new ArrayList<>();
        int nombredentres=0;
        int nombrededate=0;


        int h=0;

        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM `dentres`");



            while(rs.next()){

                String message = rs.getString("message");
                int montant = rs.getInt("montant");
                Date inputdate =rs.getDate("date");
                DEntres entres=new DEntres(inputdate,message,montant);

                listedesentres.add(entres);

                nombredentres=listedesentres.size();
                nombrededate=listedesdate.size();
                System.out.println(nombrededate+"="+listedesdate.size());

                int z=0;

                while (z<nombrededate){

                    if ((inputdate.toString()).equals(listedesdate.get(z).toString())){
                        z=nombrededate+4;
                    }else {
                        z++;
                    }
                }
                if (z==nombrededate){
                    listedesdate.add(inputdate.toString());
                    System.out.println(inputdate+" la date");
                }


                h=h+1;
            }

        }
        catch (Exception exc){
            System.out.println(exc);
        }

        System.out.println("le nombre de date : "+nombrededate);
        int totaltotal = 0;

        int x=0;

        nombredentres=listedesentres.size();
        nombrededate=listedesdate.size();


        System.out.println("le nombre de date : "+nombrededate);
        System.out.println("le nombre des entree : "+nombredentres);
        while (x<nombrededate){

            System.out.println(x+"="+nombrededate);
            int sommedate=0;
            String datedujour = listedesdate.get(x);
            lists.add(datedujour);
            System.out.println("2"+datedujour+" sur "+nombrededate);
            int xy=0;
            while (xy<nombredentres){
                System.out.println(listedesentres.get(xy).getDate());
                if (datedujour.equals(listedesentres.get(xy).getDate().toString())){

                    System.out.println("eee"+nombredentres);

                    String vale="               [E] "+listedesentres.get(xy).getMessage()+" : "+listedesentres.get(xy).getMontant()+" FCFA"  ;
                    lists.add(vale);
                    System.out.println("3"+vale);
                    sommedate=sommedate+listedesentres.get(xy).getMontant();

                }

                xy++;
            }
            x++;

            String totalprojet=""+sommedate;
            lists.add("Total  : "+totalprojet);
            totaltotal=totaltotal+sommedate;
        }
        String total = ""+totaltotal;
        lists.add("Total des entrées : "+total);



        return listedesentres;

    }

    public ArrayList<DSortie> recherches(){

        ArrayList<String> listedesdates = new ArrayList<>();
        ArrayList<String> listedesprojets = new ArrayList<>();
        ArrayList<String> lists = new ArrayList<String>();
        ArrayList<DSortie> listedesortie = new ArrayList<>();
        int nombredesorties=0;
        int nombrededates=0;
        int nombredeprojet=0;

        int h=0;

        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM `dsortie`");
            while(rs.next()){

                int idproj = rs.getInt("idProjet");
                String message = rs.getString("message");
                int montants = rs.getInt("montant");
                Date inputdates = rs.getDate("date");

                String vales="               [S] "+message+" : "+montants+" FCFA"  ;

                DSortie sortie=new DSortie(idproj,getProjetById(idproj).getNomProjet(),montants,message,vales,inputdates);

                listedesortie.add(sortie);


                nombrededates=listedesdates.size();

                System.out.println("ajoutlist "+listedesortie.size());
                int z=0;

                while (z<nombrededates){

                    if ((inputdates.toString()).equals(listedesdates.get(z).toString())){
                        z=nombrededates+4;
                    }else {
                        z++;
                    }
                }
                if (z==nombrededates){
                    listedesdates.add(inputdates.toString());
                    System.out.println(inputdates+" la date");
                }


                h=h+1;
            }


            ResultSet rs1 = stmt.executeQuery("SELECT * FROM `dprojet`");
            while(rs1.next()){


                String nomprojproj = rs1.getString("nomprojet");

                listedesprojets.add(nomprojproj);
                System.out.println("projet1"+listedesprojets);
                System.out.println(listedesortie.size());


                h=h+1;
            }

        }
        catch (Exception exc){
            System.out.println(exc);
        }



        System.out.println("projet"+listedesprojets);
        System.out.println("dates"+listedesdates);

        nombredeprojet=listedesprojets.size();
        nombredesorties=listedesortie.size();
        nombrededates=listedesdates.size();
        int y=0;
        System.out.println("nombre de proj,dat,sort :"+nombredeprojet+" "+nombrededates+" "+nombredesorties);

        int totaltotal = 0;
        while (y<nombredeprojet){
            int sommeprojet=0;
            String nomduprojet = listedesprojets.get(y);
            lists.add(nomduprojet);
            System.out.println("1"+nomduprojet);
            int x=0;
            while (x<nombrededates){
                String datedujour = listedesdates.get(x).toString();
                lists.add("        "+datedujour);
                System.out.println("2"+datedujour);
                int xy=0;
                while (xy<nombredesorties){
                    System.out.println(nomduprojet+"    "+getProjetById(listedesortie.get(xy).getIdProjet()).getNomProjet()+ " && " +datedujour.toString()+"    "+listedesortie.get(xy).getDate().toString());
                    if (nomduprojet.equals(getProjetById(listedesortie.get(xy).getIdProjet()).getNomProjet()) && (datedujour.toString()).equals(listedesortie.get(xy).getDate().toString())){

                        String vals="               [S] "+listedesortie.get(xy).getMessage()+" : "+listedesortie.get(xy).getMontant()+" FCFA"  ;
                        lists.add(vals);
                        System.out.println("3"+vals);
                        sommeprojet=sommeprojet+listedesortie.get(xy).getMontant();

                    }
                    System.out.println(nomduprojet+"="+getProjetById(listedesortie.get(xy).getIdProjet())+" et "+listedesortie.get(xy).getDate()+"="+datedujour);


                    xy++;
                }
                x++;
            }
            String totalprojet=""+sommeprojet;
            lists.add("Total "+nomduprojet+" : "+totalprojet);
            totaltotal=totaltotal+sommeprojet;


            y++;
        }
        String total = ""+totaltotal;
        lists.add("Total de tous les projets : "+total);

        System.out.println("sortie list");


        return listedesortie;

    }

    public ArrayList<String> recherchesproj(int idprojet) throws SQLException {

        ArrayList<String> listedesdates = new ArrayList<>();
        ArrayList<String> listedesprojets = new ArrayList<>();
        ArrayList<String> lists = new ArrayList<String>();
        ArrayList<DSortie> listedesortie = new ArrayList<>();
        int nombredesorties=0;
        int nombrededates=0;
        int nombredeprojet=0;



        int h=0;

        try{

            System.out.println("hgjhknl,ml;gjhknl,;");

            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM `dsortie` WHERE `idProjet` ='"+idprojet+"'");


            System.out.println("hgjhknl,ml;gjhknl,;");

            while(rs.next()){

                System.out.println("hgjhknl,ml;gjhknl,;");

                int idproj = rs.getInt("idProjet");
                String message = rs.getString("message");
                int montants = rs.getInt("montant");
                Date inputdates = rs.getDate("date");


                String vales="               [S] "+message+" : "+montants+" FCFA"  ;

                System.out.println("valeur"+vales);
                DSortie sortie=new DSortie(idproj,montants,message,vales,inputdates);

                listedesortie.add(sortie);


                nombrededates=listedesdates.size();

                System.out.println("ajoutlist "+listedesortie.size());
                int z=0;

                while (z<nombrededates){

                    if ((inputdates.toString()).equals(listedesdates.get(z))){
                        z=nombrededates+4;
                    }else {
                        z++;
                    }
                }
                if (z==nombrededates){
                    listedesdates.add(inputdates.toString());
                    System.out.println(inputdates+" la date");
                }

                h=h+1;
            }

        }
        catch (Exception exc){
            System.out.println(exc);
        }


        listedesprojets=new ArrayList<>();
        System.out.println("projet0"+listedesprojets);


        System.out.println("dates"+listedesdates);

        nombredesorties=listedesortie.size();
        nombrededates=listedesdates.size();
        int y=0;
        System.out.println("nombre de proj,dat,sort :"+nombredeprojet+" "+nombrededates+" "+nombredesorties);

        int sommeprojet=0;
        int x=0;
        while (x<nombrededates){
            String datedujour = listedesdates.get(x);
            lists.add("        "+datedujour);
            System.out.println("2"+datedujour);
            int xy=0;
            while (xy<nombredesorties){
                if ((datedujour.toString()).equals(listedesortie.get(xy).getDate().toString())){

                    String vals="               [S] "+listedesortie.get(xy).getMessage()+" : "+listedesortie.get(xy).getMontant()+" FCFA"  ;
                    lists.add(vals);
                    System.out.println("3"+vals);
                    sommeprojet=sommeprojet+listedesortie.get(xy).getMontant();

                }
                System.out.println(getProjetById(listedesortie.get(xy).getIdProjet()).getNomProjet()+" et "+listedesortie.get(xy).getDate()+"="+datedujour);


                xy++;
            }
            x++;
        }
        String totalprojet=""+sommeprojet;
        lists.add("Total : "+totalprojet);


        System.out.println("sortie list");



        return lists;

    }






    public Projet getProjetById(int id ){


        Projet projet = new Projet();

        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM `dprojet` WHERE `id`='"+id+"'");



            while(rs.next()){

                projet.setId(rs.getInt("id"));
                projet.setNomProjet(rs.getString("nomprojet"));
                projet.setStatut(rs.getInt("statut"));
            }

        }
        catch (Exception exc){
            System.out.println(exc+"  error connect");
        }
        System.out.println("  get permission name");

        return projet;

    }
    public user getUserByToken(String token ){


        String passWord="",mail="";
        user membre = new user();


        try{


            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/geldverwalten_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM `user` WHERE `token`='"+token+"'");



            while(rs.next()){
                membre.setId(rs.getInt("id"));
                membre.setNom(rs.getString("nom"));
                membre.setPrenom(rs.getString("prenom"));
                membre.setEmail(rs.getString("email"));
                membre.setPseudo(rs.getString("pseudo"));
                membre.setMotdepasse(rs.getString("password"));


                System.out.println(membre);
            }

        }
        catch (Exception exc){
            System.out.println(exc+"  error connect");
        }
        System.out.println("  MemberConn well connect");

        return membre;

    }



    public int getProjetId(String nom){
        System.out.println("  get projet id start");
        int id=0;

        System.out.println("nom du projet dont je veux l'id : "+nom);

        try{

            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/synes_db", "root", "");

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT `id` FROM `dprojet`  WHERE `nomprojet`='"+nom+"'");



            while(rs.next()){
                id = rs.getInt("id");

                System.out.println("id projet: "+id);

            }

        }
        catch (Exception exc){
            System.out.println(exc+"  error connect id projet");
        }
        System.out.println("  id de cet projet well getted");

        return id;
    }

}



