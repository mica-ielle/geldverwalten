package com.NTMG.Geldverwalten.Model.token;


import com.NTMG.Geldverwalten.Model.BaseDeDonnee;
import com.NTMG.Geldverwalten.Model.user;
import org.springframework.security.core.userdetails.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class JwtUserDetailsService implements UserDetailsService {

	/*@Autowired
	private UserDao userDao;*/
	BaseDeDonnee bd = new BaseDeDonnee();

	@Autowired
	private PasswordEncoder bcryptEncoder;

	@Override
	public UserDetails loadUserByUsername(String mail) throws UsernameNotFoundException {
		user user = bd.verif_email(mail);

		if (user == null) {
			throw new UsernameNotFoundException("User not found with email adress : " + mail);
		}
		return new User(user.getEmail(), user.getMotdepasse(),
				new ArrayList<>());


	}

	public user save(user member) {
		user memberConn = new user();
		memberConn.setEmail(member.getEmail());
		memberConn.setMotdepasse(bcryptEncoder.encode(member.getMotdepasse()));
		return memberConn;
	}
}