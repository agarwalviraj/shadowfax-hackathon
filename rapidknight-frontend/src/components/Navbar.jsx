import React, { useState } from "react";
import logo from "../assets/large_rapidknight.png";
import baskt from "../assets/Vector.png";
import register from "../assets/Group.png";
import "./navbar.css";
import { Link } from "react-router-dom";

import { db } from "./Firebase";
import { Info } from "@material-ui/icons";

const Navbar = () => {
  // const { user, setUser } = useState([]);

  // window.addEventListener("load", () => {
  //   Fetchdata();
  // });

  // const Fetchdata = () => {
  //   db.collection("data")
  //     .get()
  //     .then((querysnapshot) => {
  //       querysnapshot.forEach((element) => {
  //         var data = element.data();
  //         setUser((arr) => [...arr, data]);
  //       });
  //     });
  // };

  return (
    <div className="navbar">
      <div className="logo-container">
        <Link to="/home" className="link1">
          <img src={logo} alt="" className="logo" />
        </Link>
        <Link to="/marketplace" className="link2">
          <p className="place">market place</p>
        </Link>
      </div>
      <div className="user-info">
        <span className="basket">
          <img src={baskt} alt="" className="bask" />
        </span>
        <img src={register} alt="" className="welco" />{" "}
        <p className="we">Welcome amit</p>
      </div>
    </div>
  );
};

export default Navbar;
