import React, { useEffect, useState } from "react";
import { auth, registerWithEmailAndPassword } from "../components/Firebase";
import vector from "../assets/login.png";
import { useAuthState } from "react-firebase-hooks/auth";
import "./register.css";
import { Link, useHistory } from "react-router-dom";
const Register = () => {
  // const [email, setEmail] = useState("");
  // const [name, setName] = useState("");
  // const [password, setPassword] = useState("");
  // const [user, loading, error] = useAuthState(auth);
  // const history = useHistory();
  // const register = () => {
  //   if (!name) alert("Please enter name");
  //   registerWithEmailAndPassword(name, email, password);
  // };
  // useEffect(() => {
  //   if (user) history.replace("/home");
  // }, [user]);
  return (
    <div className="box">
      <img src={vector} alt="" className="vector" />
      <div className="container">
        <h2>Welcome</h2>
        <div className="dash"></div>
        <p className="signin">Create a new account</p>
        <div className="email-box">
          <label>Name</label>
          <input
            type="text"
            placeholder="Kson"
            className="type-email"
            // value={name}
            // onChange={(e) => setName(e.target.value)}
          />
        </div>
        <div className="password-box">
          <label>Email</label>
          <input
            type="text"
            placeholder="kson111@example.com"
            className="type-email"
            // value={email}
            // onChange={(e) => setEmail(e.target.value)}
          />
        </div>
        <div className="password-box">
          <label>Password</label>
          <input
            type="password"
            placeholder="enter your password"
            className="type-email"
            // value={password}
            // onChange={(e) => setPassword(e.target.value)}
          />
        </div>
        <Link to="/home" className="link">
          <button
            className="register__btn"
            // onClick={register}
          >
            Register
          </button>
        </Link>
        <p className="accnt-2">already have an account?</p>
        <Link className="link" to="/">
          <p className="rej-3">sigin here</p>
        </Link>
        {/* <button className="submit">Create Store</button> */}
      </div>
    </div>
  );
};

export default Register;
