package kr.co.uclick.repository;

import kr.co.uclick.entity.Sample;

public interface CustomSampleRepository {

	public void doSample(String name);
	
	public Sample selectOne(Long id);
	
	void updateOne(Sample sample);
}
