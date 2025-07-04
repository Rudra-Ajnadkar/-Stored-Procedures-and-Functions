DELIMITER //

CREATE PROCEDURE GetOrdersByCustomer(IN input_customer_id INT)
BEGIN
    SELECT o.OrderID, o.OrderDate
    FROM Orders o
    WHERE o.CustomerID = input_customer_id;
END //

DELIMITER ;

CALL GetOrdersByCustomer(1);

DELIMITER //

CREATE FUNCTION GetTotalSpent(customer_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    
    SELECT SUM(od.Quantity * od.Price)
    INTO total
    FROM Orders o
    JOIN OrderDetail od ON o.OrderID = od.OrderID
    WHERE o.CustomerID = customer_id;

    RETURN IFNULL(total, 0);
END //

DELIMITER ;

SELECT Name, GetTotalSpent(CustomerID) AS TotalSpent
FROM Customers;



