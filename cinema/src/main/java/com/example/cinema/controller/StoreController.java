package com.example.cinema.controller;

import com.example.cinema.dao.ProductDAO;
import com.example.cinema.dto.ProductDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/store/")
public class StoreController {

    @Autowired
    ProductDAO productDAO;

    @GetMapping("list.do")
    public String list(
            Model model
    ) {
        List<ProductDTO> items = productDAO.list_Product();
        model.addAttribute("list", items);
        return "store/product_list";
    }

    @GetMapping("detail.do")
    public String detail(
            @RequestParam(value = "product_code") int product_code,
            Model model
    ) {
        ProductDTO dto = productDAO.detailProduct(product_code);
        model.addAttribute("dto", dto);
        return "store/product_detail";
    }
}
