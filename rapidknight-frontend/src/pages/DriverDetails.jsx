import React from "react";
import "./driverdetails.css";
import Navbar from "../components/Navbar";
import driver from "../assets/Group 92.png";
const DriverDetails = () => {
  return (
    <div className="Order4">
      <Navbar />
      <p className="track">
        <span className="track1">Track</span> Your Order
      </p>
      <div className="dash3"></div>
      <p className="your">
        Your Order Placed our riders will quickly deliver your product at your
        doorsteps
      </p>
      <div className="RiderCard">
        <p className="viraj">Rider Details</p>
        <div className="detail-container">
          <p className="detail1">Rider Name- Vedant Singh</p>
          <p className="detail1">Phone Number- 8888888888</p>
          <p className="detail1">ETA- 12min </p>
        </div>
      </div>
      <img className="driver-track" src={driver} alt="" />
    </div>
  );
};

export default DriverDetails;
