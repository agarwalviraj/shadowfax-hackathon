import React, { useState } from "react";
import { useParams } from "react-router-dom";
import Navbar from "../components/Navbar";
import Product_Data from "../components/DATA.json";
import "./basket.css";
import Payment from "../components/Payment";
import "aos/dist/aos.css";
import AOS from "aos";

AOS.init();
const Basket = () => {
  const [display, setDisplay] = useState(false);
  const [count, setCount] = useState(1);
  const [details, setDetails] = useState(false);
  const { id } = useParams();
  const orderData = Product_Data.filter((arr) => arr.id === Number(id))[0];
  console.log(id);
  return (
    <div>
      <div>
        <Navbar />{" "}
      </div>
      <p className="marketpl">
        <span className="mar">Manage</span> Your Basket
      </p>
      <div className="dash7"></div>
      <p className="or">
        Order the product from neares market place at best price and get
        delivered it right to your doorsteps within few minutes
      </p>
      <div className="order-container">
        <img
          src={orderData.url}
          alt=""
          className="img-alt"
          data-aos="fade-right"
          data-aos-duration="1000"
          data-aos-easing="ease-out"
        />
        <div className="copy-field">
          <div className="text-fie">
            <p className="ti">{orderData.title}</p>
            <p className="ti2">{orderData.Description}</p>
          </div>
          <div className="copy-field2">
            <div className="quanity">
              <div className="qty">
                <p>Quantity</p>{" "}
                <div className="counter1">
                  <button
                    className="bmm"
                    onClick={() => {
                      setCount(count - 1);
                    }}
                  >
                    -
                  </button>
                  <p className="g">{count}</p>
                  <button
                    className="bmm"
                    onClick={() => {
                      setCount(count + 1);
                    }}
                  >
                    +
                  </button>
                </div>
              </div>
              <div className="qty2">
                <p>
                  Total Amount{" "}
                  <p className="price">{orderData.price * count}</p>
                </p>
              </div>
            </div>
            <div className="btm">
              <div
                className="pay1"
                data-aos="fade-left"
                data-aos-duration="1000"
                data-aos-easing="ease-out"
              >
                <p className="apply">Apply discount Coupons</p>
                <input className="coupon" placeholder="X15C34BT" />
              </div>
              <button
                className="bn-3"
                onClick={() => {
                  setDisplay(!display);
                }}
              >
                Place order
              </button>
            </div>
          </div>
        </div>
      </div>
      {display && <Payment closeAlert={setDisplay} />}
    </div>
  );
};

export default Basket;
