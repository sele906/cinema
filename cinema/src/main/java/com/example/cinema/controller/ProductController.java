package com.example.cinema.controller;

import com.example.cinema.dao.ProductDAO;
import com.example.cinema.dto.ProductDTO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.http.HttpRequest;
import java.util.List;
import java.io.File;

@RequestMapping("/product/")
@Controller
public class ProductController {

    @Autowired
    ProductDAO productDAO;

    @GetMapping("list.do")
    public String list(
        Model model
    ) {
        List<ProductDTO> items = productDAO.list_Product();
        model.addAttribute("list", items);
        return "shop/product_list";
    }

    @GetMapping("detail.do")
    public String detail(
            @RequestParam(name = "product_code") int product_code,
            Model model
    ) {
        ProductDTO dto = productDAO.detailProduct(product_code);
        model.addAttribute("dto", dto);
        return "shop/product_detail";
    }

    @PostMapping("insert_product.do")
    public String insert_product (
            @RequestParam(name = "product_name") String product_name,
            @RequestParam(name = "product_type") int product_type,
            @RequestParam(name = "price") int price,
            @RequestParam(name = "description") String description,
            ServletContext application,
            HttpServletRequest request
    ) {
        application = request.getSession().getServletContext();
        String img_path = application.getRealPath("/images/");
        String filename = "";
        try {

            for (Part part : request.getParts()) {
                filename = part.getSubmittedFileName();
                if (filename != null && !filename.trim().equals("")) {
                    part.write(img_path + filename);
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        ProductDTO dto = new ProductDTO();
        dto.setProduct_name(product_name);
        dto.setProduct_type(product_type);
        dto.setPrice(price);
        dto.setDescription(description);
        if (filename == null || filename.trim().equals("")) {
            filename = "-";
        }
        dto.setFilename(filename);
        productDAO.insertProduct(dto);

        return "redirect:/product/list.do";
    }

    @GetMapping("edit.do")
    public String edit(
            @RequestParam(name = "product_code") int product_code,
            Model model
    ) {
        ProductDTO dto = productDAO.detailProduct(product_code);
        model.addAttribute("dto", dto);
        return "shop/product_edit";

    }

    @PostMapping("update.do")
    public String update (
            @RequestParam(name = "product_code") int product_code,
            @RequestParam(name = "product_name") String product_name,
            @RequestParam(name = "product_type") int product_type,
            @RequestParam(name = "price") int price,
            @RequestParam(name = "description") String description,
            @RequestParam(name = "file") MultipartFile file,
            HttpServletRequest request
    ) {
        ServletContext application = request.getServletContext();
        String img_path = application.getRealPath("/resources/images/store/");
        String filename = "";

        try {
            if (file != null && !file.isEmpty()) {
                filename = file.getOriginalFilename();
                file.transferTo(new File(img_path + filename));
            } else {
                ProductDTO dto2 = productDAO.detailProduct(product_code);
                filename = dto2.getFilename();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        ProductDTO dto = new ProductDTO();
        dto.setProduct_name(product_name);
        dto.setProduct_type(product_type);
        dto.setPrice(price);
        dto.setDescription(description);
        dto.setProduct_code(product_code);
        if (filename == null || filename.trim().equals("")) {
            ProductDTO dto2 = productDAO.detailProduct(product_code);
            filename = dto2.getFilename();
            dto.setFilename(filename);
        } else {
            dto.setFilename(filename);
        }

        productDAO.updateProduct(dto);
        return "redirect:product/list.do";
    }

    @GetMapping("delete.do")
    public String delete(
            @RequestParam(name = "product_code") int product_code,
            Model model
    ) {
        productDAO.deleteProduct(product_code);
        return "redirect:product/list.do";
    }

    @GetMapping("category.do")
    public String category(
            @RequestParam(name = "product_type") int product_type,
            Model model
    ) {
        List<ProductDTO> items = productDAO.category(product_type);
        model.addAttribute("list", items);
        model.addAttribute("num", product_type);
        return "store/category_list";
    }

    @GetMapping("write.do")
    public String write() {
        return "shop/product_write";
    }
}