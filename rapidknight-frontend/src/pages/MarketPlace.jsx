import React, { useState } from "react";
import SearchBar from "../components/SearchBar";
import { Link } from "react-router-dom";
import Navbar from "../components/Navbar";
import "./marketplace.css";
import ProductCard from "../components/ProductCard";
import JSON from "../components/DATA.json";

import "react-toastify/dist/ReactToastify.css";

import PopularCarousel from "../components/PopularCarousel";

import "aos/dist/aos.css";
import AOS from "aos";
AOS.init();

const MarketPlace = () => {
  const product = JSON;
  // const kroduct = KSON;
  const [searchTerm, setSearchTerm] = useState("");

  const YourProduct = JSON.filter((item) => {
    if (searchTerm === "") {
      return null;
    } else if (item.title.toLowerCase().includes(searchTerm.toLowerCase())) {
      return item;
    }
  }).map((item) => {
    return (
      <div className="card-pro2" key={item.id}>
        <div className="cards2" data-aos="fade-down" data-aos-duration="1200">
          <img src={item.url} alt="" className="img12" />
          <div className="car2">
            <p className="tit2">{item.title}</p>
            <p className="desc2">{item.Description}</p>
            <p className="desc2">Price: {item.price}</p>
          </div>
        </div>

        <Link to={`/basket/${item.id}/${item.title}`}>
          <button className="add">Add to Basket</button>
        </Link>
      </div>
    );
  });

  return (
    <div>
      <Navbar />

      <p className="marketpl">
        <span className="mar">Market</span> Place
      </p>
      <div className="dash3"></div>
      <p className="psearch">
        search for your desired products and we will deliver it at your
        doorsteps right from your favorite marketplace
      </p>
      <div className="sercht">
        <div className="aers">
          <input
            type="text"
            placeholder="Search your product..."
            className="search"
            value={searchTerm}
            onChange={(event) => {
              setSearchTerm(event.target.value);
            }}
          />
          <button className="search-button">Search</button>
        </div>
        <div
          className="search-container"
          data-aos="fade"
          data-aos-duration="600"
        >
          <Link to="/marketplace">
            {" "}
            <button className="search-filter">fruits and Vegetables</button>
          </Link>
          <Link to="/marketplace">
            <button className="search-filter">Dairy</button>
          </Link>
          <Link to="/marketplace">
            <button className="search-filter">Staples</button>
          </Link>
          <Link to="/marketplace">
            <button className="search-filter">beverages</button>
          </Link>
        </div>
      </div>
      <div className="hover">
        <PopularCarousel />
      </div>
      <p className="popular2">
        <span className="p">Your</span> Searches
      </p>
      <div className="dif">{YourProduct}</div>
    </div>
  );
};

export default MarketPlace;
