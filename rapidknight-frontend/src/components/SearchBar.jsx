import React from "react";
import "./SearchBar.css";
import { Link } from "react-router-dom";
import "aos/dist/aos.css";

import AOS from "aos";
AOS.init();

const SearchBar = () => {
  return (
    <div>
      <Link to="/marketplace">
        {" "}
        <input
          type="text"
          placeholder="Search your product..."
          className="search"
        />
      </Link>
      <Link to="/marketplace">
        <button className="search-button">Search</button>{" "}
      </Link>

      <div className="search-container" data-aos="fade" data-aos-duration="600">
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
  );
};

export default SearchBar;
