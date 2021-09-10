import React, { useState } from "react";
import "./payment.css";
import { Link } from "react-router-dom";
const Payment = ({ closeAlert }) => {
  return (
    <div className="payment-x">
      <p className="choose">Choose Payment Method</p>
      <div>
        <div className="card-container">
          <label className="la2">card holder name</label>
          <input
            className="card-i"
            type="text"
            placeholder="enter name on card"
          />
          <label className="la">Card Number</label>
          <input className="card-i" type="text" placeholder="**** **** ****" />
          <div className="final">
            <div className="cvv">
              <label className="la">cvv</label>
              <input className="cvv2" type="text" placeholder="***" />
            </div>
            <div className="cvv">
              <label className="la">valid until</label>
              <input className="cvv3" type="text" placeholder="dd/mm/yy" />
            </div>
          </div>
        </div>
      </div>
      <Link to="/OrderDetails">
        <button>Checkout</button>
      </Link>
      <Link to="/OrderDetails">
        <button className="bn-3">Pay on delivery</button>
      </Link>
    </div>
  );
};

export default Payment;
