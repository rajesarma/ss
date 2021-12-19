package com.ss.sample.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.io.Serializable;


@Data
@SuperBuilder(toBuilder = true)
@AllArgsConstructor
@NoArgsConstructor
public class RegisterDto implements Serializable {

	private static final long serialVersionUID = -2829510863724367059L;

	private long id;

	private String userId;

	@NotBlank(message = "First Name cannot be empty")
	private String firstName;

	@NotBlank(message = "Last Name cannot be empty")
	private String lastName;

	@NotEmpty(message = "Email can not empty")
	@Email
	private String email;

	@NotEmpty(message = "Password can not empty")
	private String password;

	@NotEmpty(message = "Confirm Password can not empty")
	private String confirmPassword;

	private Boolean isRecruiter;

	//	@Pattern(regexp="[\\d]{10}")
	private String mobile;

	private String companyName;

	//	@NotEmpty(message = "Address can not empty")
	private String address;

//	@NotEmpty(message = "Postal Code can not empty")
	private String postalCode;
}
