package com.tarena.controller;

import java.sql.Date;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.tarena.dao.CostDao;
import com.tarena.dao.CostDaoImpl;
import com.tarena.entity.Cost;
import com.tarena.entity.page.CostPage;


@Controller//��Ǳ������Զ��������
@RequestMapping("/cost")//�����ʷѹ��ܵ�·��
public class CostController {
	//@Resource//��ʾ�˴���Ҫע��һ��CostDao���͵�һ������
	//CostDao costDao;//���������ʷ����ݵ���
	@RequestMapping("/findCost.do")
	public String findCost(CostPage page,Model model){
		CostDaoImpl costDao=new CostDaoImpl();
		//Page����洢��ҳ��Ϣ(��ǰҳ�룬��ǰҳ�е�����)
		//(Model�����洢���ݵģ����Խ�Page�������Model��)
		page.setRows(costDao.findRows());
		//��costDao��ѯcost���ܹ��ж��������ݣ�����������������page
		//������
		model.addAttribute("costPage",page);//����װҳ�����ݵ�page�������
		List<Cost> list=costDao.findByPage(page);
		for (Cost cost : list) {
			System.out.println(cost);
		}
		model.addAttribute("costs",list);//����page�����ҳ����Ϣ
		return "cost/cost_list";//��ѯ��һҳ��Ϣ������model��
		//��model�е�������ʾ��cost/cost_list.jsp��
	}//jdbc.properties������������Ծ�Ҫ��(oracle���ݿ������)
	
	
	//1.�����������http://localhost:8088/tr_net24_cost/cost/findCost.do
	//2.ͨ��localhost�ҵ�һ̨���ԣ�  8088�ҵ�tomcat
	//��Ŀ���ֵ�tomcat��webapps����Ҫִ�е���Ŀ
	//����cost/findCost.do�ұ�ע��cost�����µñ�ע��findCost�ķ���
	//3.ִ�д˷���
	
	
	
	//�������ҳ��ķ���
	@RequestMapping("/toAddCost.do")
	public String toAddCost(){
		return "cost/add_cost";
	}
	
	
	//�ύ������ݵķ���
	@RequestMapping("/addCost.do")
	public String addCost(Cost cost){
		CostDao costDao=new CostDaoImpl();
		cost.setStatus("1");
		cost.setCreatime(
		new Date(System.currentTimeMillis()));
		costDao.addCost(cost);
		return "redirect:findCost.do";
	}
	//��Ӳ���
	//��ʾ�����ʷ����ݵĲ���
	//������Ҫ�õ�redirect
	
	
	
	
	
	//ɾ��Cost����
	@RequestMapping("/deleteCost.do")
	public String deleteCost(@RequestParam("id")int id){
		CostDao costDao=new CostDaoImpl();
		//@RequestParam("id")��ʾ������ҳ���͵ı�����Ϊid������
		//int id�Ǹ��洢�����ݵı���������һ������
		costDao.deleteCost(id);
		//ʹ��costDao�������cost��id(�ʷ���Ϣ��id)ɾ��cost����
		return "redirect:findCost.do";
		//ɾ���ɹ�����ת����ѯ����cost���ݵ�ҳ��
	}
	
	//@RequestMapping��toUpdate������ӱ��//ͨ����
	@RequestMapping("toUpdateCost.do")//��ǾͿ���
	public String toUpdateCost(//�ҵ��˷���
			@RequestParam("id")int id,//@RequestParam
			Model model){//("id")������ҳ���ݵĲ���,
		CostDao costDao=new CostDaoImpl();
		//int id�Ǹ��˲���������һ������//
		Cost cost=costDao.findById(id);//����id�����ݿ�
		model.addAttribute("cost",cost);//��ѯ��������
		return "cost/update_cost";//���洢��model��
	}//Ȼ����ת���޸�ҳ��(���޸�ҳ����ȡmodel�е�����)
	//��ʾ������
	@RequestMapping("/updateCost.do")
	public String updateCost(Cost cost){
		CostDao costDao=new CostDaoImpl();
		costDao.updateCost(cost);//ʹ��costdao�޸��ύ
		return "redirect:findCost.do";//�����ݲ�
	}//����ҳ��ת����ʾ�����ʷ����ݵ�ҳ��
}
