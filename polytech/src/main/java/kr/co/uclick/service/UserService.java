package kr.co.uclick.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.uclick.entity.Phone;
import kr.co.uclick.entity.Sample;
import kr.co.uclick.entity.User;
import kr.co.uclick.repository.UserRepository;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserRepository userRepository;

	// Create & Update
	@CacheEvict(value = "area", allEntries = true)
	public void save(User user) {
		userRepository.save(user);
	}

	// Read
	@Cacheable(value = "area")
	@Transactional(readOnly = true)
	public List<User> findAll() {
		return userRepository.findAll();
	}

	// Read
	@Cacheable(value = "area")
	@Transactional(readOnly = true)
	public List<User> findUserByName(String name) {
		return userRepository.findUserByName(name);
	}

	@Cacheable(value = "area")
	@Transactional(readOnly = true)
	public List<User> findUserByNameContaining(String name) {
		return userRepository.findUserByNameContaining(name);
	}
	
	// Read
	@Cacheable(value = "area")
	@Transactional(readOnly = true)
	public User findById(Long userId) {
		Optional<User> ou = userRepository.findById(userId);
		User u = ou.get();
		return u;
	}
	
	@Cacheable(value = "area")
    public User selectOne(Long id) {
        return userRepository.selectOne(id);
    }
    
	// Update
    @CacheEvict(value = "area", allEntries = true)
    public void updateOne(User user) {
    	userRepository.updateOne(user);
    }
	
	// Delete
    @CacheEvict(value = "area", allEntries = true)
	public void delete(User user) {
		userRepository.delete(user);
	}
	
    // Delete
    @CacheEvict(value = "area", allEntries = true)
	public void deleteOne(User user) {
		userRepository.deleteOne(user);
	}
	
	// users 중복제거 메서드 : phone 리스트에서 user 리스트를 뽑아낼 때 사용
	public List<User> deduplication(List<User> users) {
		
		List<User> deduplicatedUsers = new ArrayList<User>();
		for (User user : users) {
		    if (!deduplicatedUsers.contains(user)) {
		    	deduplicatedUsers.add(user);
		    }
		}
		return deduplicatedUsers;
	}
}
