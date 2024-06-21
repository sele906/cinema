package com.example.cinema.dao;

import com.example.cinema.dto.ProductDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDAO {

    @Autowired
    SqlSession sqlSession;

    public List<ProductDTO> listProduct() {
        List<ProductDTO> list = sqlSession.selectList("product.list_product");
        return list;
    }
    public List<ProductDTO> list_Product() {
        List<ProductDTO> list = sqlSession.selectList("product.listproduct");
        return list;
    }
    public List<ProductDTO> category(int product_type) {
        List<ProductDTO> list = sqlSession.selectList("product.list_type",product_type);
        return list;
    }

    public ProductDTO detailProduct(int product_code) {
        ProductDTO dto = sqlSession.selectOne("product.detail_product", product_code);
        return dto;
    }

    public void insertProduct(ProductDTO dto) {
        sqlSession.insert("product.insert_product", dto);
    }

    public void updateProduct(ProductDTO dto) {
        sqlSession.update("product.update_product", dto);
    }

    public void deleteProduct(int product_code) {
        sqlSession.delete("product.delete_product", product_code);
    }
}
