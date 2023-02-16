package com.codegym.casemodule4.repositories;

import com.codegym.casemodule4.entities.OrderProduct;
import com.codegym.casemodule4.entities.OrderProductPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderProductRepository extends JpaRepository<OrderProduct, OrderProductPK> {
}