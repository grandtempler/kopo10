package kr.co.uclick.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.uclick.entity.Phone;
import kr.co.uclick.entity.User;

import kr.co.uclick.service.PhoneService;
import kr.co.uclick.service.UserService;

@Controller
public class ServiceController {

//	private static final Logger logger = LoggerFactory.getLogger(ServiceController.class);

	@Autowired
	private UserService userService;
	
	@Autowired
	private PhoneService phoneService;
	
	@Transactional(readOnly = true)
	public List<User> setUsers(String searchusername, String searchphonenumber) {
		
		List<User> users = new ArrayList<User>();
			
		if (searchusername != null && !searchusername.equals("")) { // 사용자검색 파라미터가 null이 아니고 빈 Str이 아닐 때
			users = userService.findUserByNameContaining(searchusername);
		} else if (searchphonenumber != null && !searchphonenumber.equals("")) { // 핸드폰검색 파라미터가 null이 아니고 빈 Str이 아닐 때
			List<Phone> phoneList = phoneService.findPhoneByPhonenumberContaining(searchphonenumber);
			
			for(Phone phone : phoneList) {
				users.add(phone.getUser());
			}
			users = userService.deduplication(users);

		} else {
			users = userService.findAll();
		}
		return users;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET) // 파라미터 받는 법 : get방식
	public String home(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		model.addAttribute("Samples", "홈임둥" );

		return "sample";
	}
	
	@RequestMapping(value = "/user", method = RequestMethod.GET) // 파라미터 받는 법 : get방식
	public String user(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		List<User> users = userService.findAll();

		model.addAttribute("users", users );
		model.addAttribute("id", param.get("id") );

		return "user";
	}
	
	@RequestMapping(value = "/user_1", method = {RequestMethod.GET, RequestMethod.POST}) // 파라미터 받는 법 : get방식
	public String user_1(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		String searchusername = param.get("searchusername");
		String searchphonenumber = param.get("searchphonenumber");
		
		model.addAttribute("searchusername", param.get("searchusername")); // 
		model.addAttribute("searchphonenumber", param.get("searchphonenumber")); // 
		
		List<User> users = setUsers(searchusername, searchphonenumber); // 유저 리스트가 들어갈 리스트 users 를 세팅한다.
		
		model.addAttribute("users", users ); // user list인 users 객체를 넘겨줌
		
		model.addAttribute("idpl", param.get("idpl") ); // 핸드폰 리스트를 누른 경우 들어오는 해당 사용자의 id + phonelist(pl) 파라미터를 받아 넘겨줌
		model.addAttribute("plist", param.get("plist") ); // 핸드폰 리스트를 누른 경우 들어오는 해당 사용자의 id + phonelist(pl) 파라미터를 받아 넘겨줌
		
		model.addAttribute("userup", param.get("userup") ); // 유저번호로 해당 라인을 업데이트 상태로 만들어주는 userup 파라미터를 받아 넘겨줌 
		model.addAttribute("phup", param.get("phup") ); // 업데이트할 핸드폰의 id인 phup 파라미터를 받아 다시 넘겨줌

		model.addAttribute("userinsert", param.get("userinsert")); // 유저 등록인지 여부를 판단할 수 있는 userinsert 파라미터를 받아 다시 넘겨줌
		model.addAttribute("phinsert", param.get("phinsert")); // 폰 등록인지 여부를 판단할 수 있는 phinsert 파라미터를 받아 다시 넘겨줌
		
		return "user_1";
	}
	
	@RequestMapping(value = "/user_search", method = RequestMethod.POST)
	public String user_search(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		String searchusername = param.get("searchusername");
		String searchphonenumber = param.get("searchphonenumber");
		
		System.out.println("user_search :: searchusername: " + searchusername);
		System.out.println("user_search :: searchphonenumber: " + searchphonenumber);
		
		List<User> users = setUsers(searchusername, searchphonenumber); // 유저 리스트가 들어갈 리스트 users 를 세팅한다.

		model.addAttribute("users", users );
		model.addAttribute("searchusername", param.get("searchusername"));
		model.addAttribute("searchphonenumber", param.get("searchphonenumber"));
		
		return "user_1";
	}
	
	@RequestMapping(value = "/phone_search", method = RequestMethod.POST)
	public String phone_search(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		String searchusername = param.get("searchusername");
		String searchphonenumber = param.get("searchphonenumber");
		
		List<User> users = setUsers(searchusername, searchphonenumber); // 유저 리스트가 들어갈 리스트 users 를 세팅한다.
		
		model.addAttribute("users", users );
		model.addAttribute("searchusername", param.get("searchusername"));
		model.addAttribute("searchphonenumber", param.get("searchphonenumber"));
		
		return "user_1";
	}
	
	@RequestMapping(value = "/user_insert", method = RequestMethod.POST)
	public String user_insert(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		String name = param.get("name");
		String age = param.get("age");
		String sex = param.get("sex");
		String address1 = param.get("address1"); // 업데이트할 전화번호
		String address2 = param.get("address2"); // 업데이트할 텔레콤
		
		User user = new User();
		user.setName(name);
		user.setAge(age);
		user.setSex(sex);
		user.setAddress1(address1);
		user.setAddress2(address2);
		userService.save(user); // 유저 등록
		
		String searchusername = param.get("searchusername");
		String searchphonenumber = param.get("searchphonenumber");
		
		List<User> users = setUsers(searchusername, searchphonenumber); // 유저 리스트가 들어갈 리스트 users 를 세팅한다.

		model.addAttribute("users", users );
		model.addAttribute("idpl", param.get("idpl") );
		model.addAttribute("searchusername", param.get("searchusername"));
		model.addAttribute("searchphonenumber", param.get("searchphonenumber"));
		
		return "user_1";
	}
	
	
	@RequestMapping(value = "/user_update", method = RequestMethod.POST)
	public String user_update(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		String userup = param.get("userup"); // 업데이트할 유저의 아이디
		String name = param.get("name");
		String age = param.get("age");
		String sex = param.get("sex");
		String address1 = param.get("address1"); // 업데이트할 전화번호
		String address2 = param.get("address2"); // 업데이트할 텔레콤
		
		User user = new User();
		user.setId(Long.parseLong(userup));
		user.setName(name);
		user.setAge(age);
		user.setSex(sex);
		user.setAddress1(address1);
		user.setAddress2(address2);
		userService.updateOne(user); // 유저 업데이트
		
		String searchusername = param.get("searchusername");
		String searchphonenumber = param.get("searchphonenumber");
		
		System.out.println("user_update :: searchusername: " + searchusername);
		System.out.println("user_update :: searchphonenumber: " + searchphonenumber);
		
		List<User> users = setUsers(searchusername, searchphonenumber); // 유저 리스트가 들어갈 리스트 users 를 세팅한다.

		model.addAttribute("users", users );
		model.addAttribute("idpl", param.get("idpl") );
		model.addAttribute("searchusername", param.get("searchusername"));
		model.addAttribute("searchphonenumber", param.get("searchphonenumber"));
		
		return "user_1";
	}
	
	@RequestMapping(value = "/user_delete", method = {RequestMethod.GET, RequestMethod.POST}) // DB에서 phone 테이블 외래키를 RESTRICT에서 CASCADE로 변경해야 한다.
	public String user_delete(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		String userdel = param.get("userdel"); // 삭제할 유저의 아이디

		User user = userService.selectOne(Long.parseLong(userdel));

		userService.deleteOne(user); // 유저 삭제
		
		String searchusername = param.get("searchusername");
		String searchphonenumber = param.get("searchphonenumber");
		
		List<User> users = setUsers(searchusername, searchphonenumber); // 유저 리스트가 들어갈 리스트 users 를 세팅한다.

		model.addAttribute("users", users );
		model.addAttribute("idpl", param.get("idpl") );
		model.addAttribute("searchusername", param.get("searchusername"));
		model.addAttribute("searchphonenumber", param.get("searchphonenumber"));
		
		return "user_1";
	}
	
	@RequestMapping(value = "/phone_insert", method = RequestMethod.POST)
	public String phone_insert(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		String idpl = param.get("idpl"); // 유저의 아이디
		String phonenumber = param.get("phonenumber"); // 업데이트할 전화번호
		String telecom = param.get("telecom"); // 업데이트할 텔레콤
		
		if (phoneService.phoneInsertDuplicationChk(phonenumber)) {
			
			Phone phone = new Phone();
			phone.setPhonenumber(phonenumber);
			phone.setTelecom(telecom);
			phone.setUser(userService.selectOne(Long.parseLong(idpl)));
			phoneService.save(phone); // 핸드폰 업데이트
			
			String searchusername = param.get("searchusername");
			String searchphonenumber = param.get("searchphonenumber");
			
			List<User> users = setUsers(searchusername, searchphonenumber); // 유저 리스트가 들어갈 리스트 users 를 세팅한다.
	
			model.addAttribute("users", users );
			model.addAttribute("idpl", param.get("idpl") );
			model.addAttribute("searchusername", param.get("searchusername"));
			model.addAttribute("searchphonenumber", param.get("searchphonenumber"));
			
			return "user_1";

		} else {
			model.addAttribute("alertplace", "Phone Insert");
			model.addAttribute("alertmessage", "중복된 핸드폰 번호입니다.");
			
			return "alert";
		}
	}
	
	
	@RequestMapping(value = "/phone_update", method = RequestMethod.POST)
	public String phone_update(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		String idpl = param.get("idpl"); // 유저의 아이디
		String phonenumber = param.get("phonenumber"); // 업데이트할 전화번호
		String telecom = param.get("telecom"); // 업데이트할 텔레콤
		String phid = param.get("phid"); // 해당 유저의 수정할 핸드폰 아이디
		
		if (phoneService.phoneUpdateDuplicationChk(phonenumber, Long.parseLong(phid))) {
			
			Phone phone = new Phone();
			phone.setId(Long.parseLong(phid));
			phone.setPhonenumber(phonenumber);
			phone.setTelecom(telecom);
			phone.setUser(userService.selectOne(Long.parseLong(idpl)));
			phoneService.updateOne(phone); // 핸드폰 업데이트
			
			String searchusername = param.get("searchusername");
			String searchphonenumber = param.get("searchphonenumber");
			
			List<User> users = setUsers(searchusername, searchphonenumber); // 유저 리스트가 들어갈 리스트 users 를 세팅한다.
	
			model.addAttribute("users", users );
			model.addAttribute("idpl", param.get("idpl") );
			model.addAttribute("searchusername", param.get("searchusername"));
			model.addAttribute("searchphonenumber", param.get("searchphonenumber"));
			
			return "user_1";

		} else {
			
			model.addAttribute("alertplace", "Phone Update");
			model.addAttribute("alertmessage", "중복된 핸드폰 번호입니다.");
			
			return "alert";
		}
	}
	
	@RequestMapping(value = "/phone_delete", method = {RequestMethod.GET, RequestMethod.POST})
	public String phone_delete(Locale locale, @RequestParam Map<String, String> param, Model model) { // page, page당 갯수 : itemCountPerPage

		String phdel = param.get("phdel"); // 삭제할 핸드폰의 아이디

		Phone phone = phoneService.selectOne(Long.parseLong(phdel));
		
		phoneService.deleteOne(phone); // 핸드폰 삭제
		
		String searchusername = param.get("searchusername");
		String searchphonenumber = param.get("searchphonenumber");
		
		List<User> users = setUsers(searchusername, searchphonenumber); // 유저 리스트가 들어갈 리스트 users 를 세팅한다.

		model.addAttribute("users", users );
		model.addAttribute("idpl", param.get("idpl") );
		model.addAttribute("searchusername", param.get("searchusername"));
		model.addAttribute("searchphonenumber", param.get("searchphonenumber"));
		
		return "user_1";
	}
}
