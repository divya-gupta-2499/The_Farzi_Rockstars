package com.khushi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.khushi.dao.OrderDAO;
import com.khushi.dao.ProductDAO;
import com.khushi.model.Product;
import java.util.List;
import com.khushi.model.Category;

@Controller
public class ProductController {

	@Autowired
	ProductDAO productdao;
	@Autowired
	OrderDAO orderdao;

	@RequestMapping(value = "/products", method = RequestMethod.GET)
	public ModelAndView prod(@RequestParam(value = "msg", required = false) String msg) {
		ModelAndView model = new ModelAndView("product");
		if (msg != null) {		
			model.addObject("msg", /*"Product Added Successfully!"*/ msg);
			/*model.addObject("categories", productdao.getCategory());
			model.addObject("products", productdao.findAllProducts());*/
		}
		model.addObject("categories", productdao.getCategory());
		model.addObject("products", productdao.findAllProducts());
		return model;
	}

	@RequestMapping(value = "/addProd", method = RequestMethod.GET)
	public ModelAndView prods() {
		ModelAndView model = new ModelAndView("addProd");
		model.addObject("product", new Product());
		return model;
	}

	@RequestMapping(value = "/addProd", method = RequestMethod.POST)
	public ModelAndView prodAdd(@ModelAttribute("product") Product product) {
		int flag = 0;
		java.util.List<com.khushi.model.Category> categories = productdao.getCategory();
		for (int i = 0; i < categories.size(); i++) {
			if (categories.get(i).getCategoryName().equalsIgnoreCase(product.getCategoryName())) {
				flag = 1;
				break;
			}
		}
		if (flag == 0) {
			return new ModelAndView("addProd", "msg", "Category does not exist. Please add category.");
		}
		if (productdao.get(product.getProductId()) != null) {
			return new ModelAndView("addProd", "msg", "ProductID already exists.");
		}
		productdao.addProduct(product);
		return new ModelAndView("home", "msg", "New Product Added Successfully");
	}

	@RequestMapping(value = "/addCategory", method = RequestMethod.GET)
	public ModelAndView category() {
		ModelAndView model = new ModelAndView("addCategory");
		model.addObject("category", new Category());
		return model;
	}

	@RequestMapping(value = "/addCategory", method = RequestMethod.POST)
	public ModelAndView prodAdd(@ModelAttribute("category") Category category) {
		int flag = 0;
		List<Category> categories = productdao.getCategory();
		for (int i = 0; i < categories.size(); i++) {
			if (categories.get(i).getCategoryName().equalsIgnoreCase(category.getCategoryName())) {
				flag = 1;
				break;
			}
		}
		if (flag == 1) {
			return new ModelAndView("addCategory", "msg", "Category already exists.");
		}

		productdao.addCategory(category);
		return new ModelAndView("addCategory", "msg", "Category added successfuly.");
	}

	@RequestMapping(value = "/products/{categoryName}", method = RequestMethod.GET)
	public ModelAndView prod2(@PathVariable("categoryName") String categoryName) {
		ModelAndView model = new ModelAndView("prodPerCategory");
		model.addObject("categoryName", categoryName);
		model.addObject("products", productdao.findAll(categoryName));
		return model;
	}

	@RequestMapping(value = "/updateProd/{productId}", method = RequestMethod.GET)
	public ModelAndView updateProduct(@PathVariable("productId") String productId) {
		Product product = productdao.get(productId);
		ModelAndView model = new ModelAndView("updateProd");
		model.addObject("product", product);
		return model;
		// return new ModelAndView("product", "categories", productdao.getCategory());
	}

	@RequestMapping(value = "/updateProd/{productId}", method = RequestMethod.POST)
	public ModelAndView updateProducts(@ModelAttribute("product") Product product) {
		productdao.addProduct(product);
		String pId = product.getProductId();
		return new ModelAndView("product", "msg", "Product " + pId + " Updated.");
		// return new ModelAndView("product", "categories", productdao.getCategory());
	}

	@RequestMapping(value = "/deleteProd/{productId}", method = RequestMethod.GET)
	public String deleteProd(@PathVariable("productId") String productId) {
		if (orderdao.isProductInOrders(productId)) {
			return "redirect:/products?msg=" + "This product is ordered by some customer. Hence cannot be deleted.";
			/*return new ModelAndView("product", "msg",
					"This product is ordered by some customer. Hence cannot be deleted.");*/
		}
		productdao.deleteProduct(productId);
		return "redirect:/products?msg=" + "Product deleted.";
		//return new ModelAndView("product", "msg", "Product deleted.");
	}
}