package com.promore.customer.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.promore.customer.dto.CustomerDto;
import com.promore.customer.service.CustomerService;
import com.promore.manager.service.ManagerService;

/**
 * @Author	: sohyunkim
 * @Descriptions : 고객게시판(1:1문의하기, 공지사항)
 */
@Controller
public class CustomerController {
	@Autowired
	private CustomerService customerService;
	private ManagerService noticeService;
	
	public CustomerController() {}

	public CustomerController(CustomerService customerService) {
		this.customerService = customerService;
	}

	public void setCustomerServicee(CustomerService customerService) {
		this.customerService = customerService;
	}
	
	@RequestMapping(value = "/customer/inquireList.do", method = RequestMethod.GET)
	public ModelAndView customerBoardList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("request", request);
		
		customerService.customerBoardList(mav);
		return mav;		
	}
	
	@RequestMapping(value = "/customer/inquireWrite.do", method = RequestMethod.POST)
	public void customerBoardWrite(HttpServletRequest request, HttpServletResponse response, CustomerDto customerDto) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("customerDto", customerDto);
		
		customerService.customerBoardWriteOk(mav);
		
		response.setHeader("Content-Type", "application/json;charset=utf-8");
		try {
			response.getWriter().println(mav.getModel().get("check"));
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/customer/inquireDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public void customerBoardDelete(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("request", request);
		
		customerService.customerBoardDeleteOk(mav);
			
		response.setHeader("Content-Type", "application/json;charset=utf-8");
		try {
			response.getWriter().println(mav.getModel().get("check"));
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/customer/inquireUpdate.do", method = RequestMethod.POST)
	public void customerBoardUpdate(HttpServletRequest request, HttpServletResponse response, CustomerDto customerDto) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("customerDto", customerDto);
		
		customerService.customerBoardUpdateOk(mav);
		
		response.setHeader("Content-Type", "application/json;charset=utf-8");
		try {
			response.getWriter().println(mav.getModel().get("check"));
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/customer/fileDownload.do", method = RequestMethod.GET)
	public void noticeFileDownload(HttpServletRequest request, HttpServletResponse response) {		
		ModelAndView mav = new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		customerService.fileDownload(mav);
	}
	
	@RequestMapping(value = "/customer/noticeList.do", method = RequestMethod.GET)
	public ModelAndView noticeBoardList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("request", request);
		
		customerService.noticeBoardList(mav);
		
		return mav;		
	}	
	
	@RequestMapping(value = "/customer/noticeUpdateCount.do", method = RequestMethod.POST)
	public void noticeBoardUpdateCount(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("request", request);
		
		customerService.noticeBoardUpdateCount(mav); // DB
		
		response.setHeader("Content-Type", "application/json;charset=utf-8");
		try {
			response.getWriter().println(mav.getModel().get("check"));
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
