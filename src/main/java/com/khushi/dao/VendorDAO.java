package com.khushi.dao;

import java.util.List;

import com.khushi.model.VendorDetail;
import com.khushi.model.VendorProposal;

public interface VendorDAO {

	public void updateVendor(VendorDetail vendor);
	
	public void addOrUpdate(VendorDetail vendor);

	VendorDetail getVendor(String username);
	
	public boolean existsInProposal(final String username, final String productId);
	
	public void addProposal(String username, String productId, int price);
	
	public List<VendorProposal> getAllProposals();
	
	public void acceptProposal(String username, String productId);
	
	public List<VendorProposal> getAcceptedProposals(final String username);
	
}