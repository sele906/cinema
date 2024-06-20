package com.example.cinema.controller;

import com.example.cinema.dao.CartDAO;
import com.example.cinema.dto.CartDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/cart/")
public class CartController {

    @Autowired
    CartDAO cartDAO;

    @PostMapping("insert.do")
    public String insert(
            HttpSession session,
            Model model,
            @RequestParam(name = "product_code") int product_code,
            @RequestParam(name = "amount") int amount
    ) {
        String userid = (String) session.getAttribute("userid");
        CartDTO dto = new CartDTO();
        dto.setUserid(userid);
        dto.setProduct_code(product_code);
        dto.setAmount(amount);
        cartDAO.insert_cart(dto);

        return "redirect:/cart/list.do";
    }

    @GetMapping("list.do")
    public String insert(
            HttpSession session,
            Model model
    ) {
        String userid = (String) session.getAttribute("userid");
        int sum = cartDAO.sum_money(userid);
        List<CartDTO> items = cartDAO.list_cart(userid);

        model.addAttribute("sum", sum);
        model.addAttribute("list", items);

        return "/cart/cart_list";
    }

    @GetMapping("delete.do")
    public String delete(
            @RequestParam(name = "cart_id") int cart_id
    ) {
        cartDAO.delete_cart(cart_id);
        return "redirect:/cart/list.do";
    }

    @GetMapping("delete_all.do")
    public String delete_all(
            HttpSession session,
            @RequestParam(name = "cart_id") int cart_id
    ) {
        String userid = (String) session.getAttribute("userid");
        cartDAO.clear_cart(userid);
        return "redirect:/cart/list.do";
    }

    @PostMapping("update.do")
    public String update(
            HttpSession session,
            Model model,
            @RequestParam(name = "product_code") String[] product_code,
            @RequestParam(name = "cart_id") String[] cart_id,
            @RequestParam(name = "amount") String[] amount
    ) {

        String userid = (String) session.getAttribute("userid");
        CartDTO dto = new CartDTO();

        for (int i = 0; i < product_code.length; i++) {
            dto.setUserid(userid);
            dto.setCart_id(Integer.parseInt(cart_id[i]));
            dto.setAmount(Integer.parseInt(amount[i]));
            cartDAO.update_cart(dto);
        }

        return "redirect:/cart/list.do";
    }
}
