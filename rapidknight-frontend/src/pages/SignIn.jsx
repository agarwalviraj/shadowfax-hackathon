import React, { useState, useEffect } from "react";
import { auth, signInWithEmailAndPassword } from "../components/Firebase";
import vector from "../assets/login.png";
import "./signin.css";
import { useAuthState } from "react-firebase-hooks/auth";
import { Link, useHistory } from "react-router-dom";

const SignIn = () => {
  // const [email, setEmail] = useState("");
  // const [password, setPassword] = useState("");
  // const [user, loading] = useAuthState(auth);
  // const history = useHistory();
  // useEffect(() => {
  //   if (user) history.replace("/home");
  // }, [user, loading]);
  return (
    <div className="box">
      <img src={vector} alt="" className="vector" />
      <div className="container">
        <h2 className="h2">Welcome</h2>
        <div className="dash"></div>
        <p className="signin">Sign In to your account</p>
        <div className="email-box">
          <label>Email</label>
          <input
            type="text"
            placeholder="Kson111@example.com"
            className="type-email"
          />
        </div>
        <div className="password-box">
          <label>Password</label>
          <input
            type="password"
            placeholder="Type your password"
            className="type-email"
          />
        </div>
        <Link to="/home" className="link">
          <button className="submit">Sign In</button>
        </Link>
        <p className="accnt">don't have an account?</p>
        <Link to="/register" className="link10">
          <p className="rej-2">register here</p>
        </Link>
      </div>
    </div>
  );
};

export default SignIn;
