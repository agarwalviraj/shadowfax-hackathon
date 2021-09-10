import React, { useContext } from "react";
import { Link } from "react-router-dom";
import "./product.css";
import JSON from "./DATA.json";
import Basket from "../pages/Basket";
// import { UserContext } from "./UserContext";

const ProductCard = () => {
  const product = JSON;
  // const { count, setCount } = useContext(UserContext);
  return (
    <div>
      <div className="cards-container">
        {product.map((item) => {
          return (
            <div className="card-pro" key={item.Popular}>
              <div className="cards">
                <img src={item.url} alt="" className="img1" />

                <p className="tit">{item.title}</p>
                <p className="desc">{item.Description}</p>
              </div>

              <button className="add">Add to Basket</button>
            </div>
          );
        })}
      </div>
    </div>
  );
};

export default ProductCard;
