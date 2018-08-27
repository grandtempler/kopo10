package kr.co.uclick.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.xml.bind.annotation.XmlElement;

import org.hibernate.annotations.Cascade;


@Entity
@Table(name = "user")
public class User {

	@Id
	@TableGenerator(name = "user")
	@GeneratedValue(strategy = GenerationType.IDENTITY, generator = "user")
	private Long id;

	@Column(length = 20)
	@XmlElement
	private String name;
	
	@Column
	@XmlElement
	private String address1;
	
	@Column
	@XmlElement
	private String address2;

	@Column
	@XmlElement
	private String sex;
	
	@Column
	@XmlElement
	private String age;
	
	// Getter Setter
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}
	
	// 외래키
	@OneToMany(mappedBy="user", fetch = FetchType.EAGER)
    private List<Phone> phoneList;

	// 외래키 Getter Setter
	public List<Phone> getPhoneList() {
		return phoneList;
	}

	public void setPhoneList(List<Phone> phoneList) {
		this.phoneList = phoneList;
	}

}
