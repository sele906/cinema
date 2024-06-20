package com.example.cinema.dao;

import java.util.List;

import com.example.cinema.dto.CartDTO;
import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAO {

	@Autowired
	SqlSession sqlSession;

	public List<CartDTO> cart_money() {
	    List<CartDTO> items = sqlSession.selectList("cart.product_money");
	    return items;
	}

	public void insert_cart(CartDTO dto) {

	    try {
			sqlSession.insert("cart.insert_cart", dto);
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	}

	public List<CartDTO> list_cart(String userid) {

	    List<CartDTO> list = null;
	    try {
			list = sqlSession.selectList("cart.list_cart", userid);
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public void delete_cart(int cart_id) {

	    try {
	        sqlSession.delete("cart.delete_cart", cart_id);
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	}

	public void update_cart(CartDTO dto) {

	    try {
	        sqlSession.update("cart.update_cart", dto);
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	}

	public void clear_cart(String userid) {

	    try {
			sqlSession.delete("cart.clear_cart", userid);
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	}

	public int sum_money(String userid) {
	    int total = 0;
		total = sqlSession.selectOne("cart.sum_money", userid);
	    return total;
	}

}
