import React from "react"
import { TextField, FormLabel, Button  } from '@mui/material';

class Login extends React.Component { 
  render() {
    return (
      <React.Fragment>
        <FormLabel>Email</FormLabel>
        <TextField 
          autoComplete="email" 
          type="email" 
          value="" 
          name="user[email]" 
          id="user_email"
        />
        <FormLabel>Password</FormLabel>
        <TextField 
          autoComplete="current-password"
          type="password" 
          value="" 
          name="user[password]" 
          id="user_password"
        />
        <div className='login-btn'>
          <Button 
            type="submit" 
            name="commit" 
            value="Log in" 
            data-disable-with="Log in" 
            size="large" 
            variant="outlined"
          >Login</Button>
        </div>
      </React.Fragment>
    )
  }
} 

export default Login
