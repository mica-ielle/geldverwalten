package com.NTMG.Geldverwalten.Controller;


import com.NTMG.Geldverwalten.Model.ApiError;
import com.NTMG.Geldverwalten.Model.BaseDeDonnee;
import com.NTMG.Geldverwalten.Model.service.EmailService;
import com.NTMG.Geldverwalten.Model.token.JwtRequest;
import com.NTMG.Geldverwalten.Model.token.JwtTokenUtil;
import com.NTMG.Geldverwalten.Model.token.JwtUserDetailsService;
import com.NTMG.Geldverwalten.Model.user;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

//@CrossOrigin(maxAge = 3600)
@RestController
public class JwtAuthenticationController {


	@Autowired
	private EmailService emailService;


	BaseDeDonnee bd = new BaseDeDonnee();
	@Autowired
	private AuthenticationManager authenticationManager;

	@Autowired
	private JwtTokenUtil jwtTokenUtil;

	@Autowired
	private JwtUserDetailsService userDetailsService;


	@RequestMapping(value = "/login", method = RequestMethod.POST, consumes= MediaType.APPLICATION_JSON_VALUE)
	public Object createAuthenticationToken(@RequestBody JwtRequest authenticationRequest, HttpServletResponse response) throws Exception {

		System.out.println(authenticationRequest.getEmail()+"     psw     "+authenticationRequest.getPassword());

		int val = bd.verif_Membre(authenticationRequest.getEmail(), authenticationRequest.getPassword());
		if (val == 1){

			authenticate(authenticationRequest.getEmail(), authenticationRequest.getPassword());


			final UserDetails userDetails = userDetailsService
					.loadUserByUsername(authenticationRequest.getEmail());


			return userDetails;
		}else {
			response.setStatus(404);
			//throw new Error("user not found");
			return new ApiError(404,"even the mail adress or the password is wrong","user not found");
		}



	}




	@RequestMapping(value = "/register", method = RequestMethod.POST, consumes= MediaType.APPLICATION_JSON_VALUE)
	public Object saveUser(@RequestBody user user, HttpServletResponse response) throws Exception {

		final UserDetails userDetails = new User(user.getEmail(), user.getMotdepasse(),
				new ArrayList<>());
		System.out.println(user.getEmail()+" jj "+user.getMotdepasse()+"  f  "+new ArrayList<>());

		String token = jwtTokenUtil.generateToken(userDetails);

		System.out.println("ce token est pour le user : "+jwtTokenUtil.getUsernameFromToken(token));
		/*user leMembre = bd.searchUser(jwtTokenUtil.getUsernameFromToken(token));
		System.out.println("membre"+leMembre);*/

		user useConnectInfo = new user(user.getNom(), user.getPrenom(), user.getPseudo(), user.getEmail(), user.getMotdepasse(),token);


		if (bd.Add_Membre(useConnectInfo)==1) {

			/*String motDePasse = user.getMatricule() + "_SYNES_" + user.getNom();

			this.emailService.sendMessage(
					user.getEmail(),
					"NOTIFICATION D'AJOUT AU SYTEME EN LIGNE DU SYNES",
					"Monsieur/Madame " + user.getNom() + " " + user.getPrenom() + ",\n Bienvenu dans la plateforme SYNES,\n votre compte viens d'être créé et \n vos informations de connexion sont:  \n email: " + user.getEmail() + " \n password: " + motDePasse+" \n\n Vous pouvez modifier votre mot de passe\n dans la section profil une fois connecté"
			);*/
			return useConnectInfo;
		}else {
			response.setStatus(404);
			//throw new Error("user not found");
			return new ApiError(404,"registration faild","user not found");

		}
	}





	@ExceptionHandler({ AuthenticationException.class })
	public ResponseEntity<String> handleAuthenticationException(AuthenticationException e)
	{
		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
	}


	private void authenticate(String username, String password)
	{
		Objects.requireNonNull(username);
		Objects.requireNonNull(password);

		try {
			/// ???
			authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
		}
		catch (DisabledException e)
		{
			System.out.println("UTENTE DISABILITATO");
			//throw new AuthenticationException("UTENTE DISABILITATO",e);
		}
		catch (BadCredentialsException e)
		{
			System.out.println("CREDENTIAL ERROR");
			//throw new AuthenticationException("CREDENTIAL ERROR", e);
		}
	}
}



