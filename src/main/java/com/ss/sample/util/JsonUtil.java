package com.ss.sample.util;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;

@Slf4j
public class JsonUtil {
	private JsonUtil() {

	}

	private static final ObjectMapper objectMapper = new ObjectMapper();

	public static byte[] toJson(Object object) throws IOException {
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		return mapper.writeValueAsBytes(object);
	}

	public static <T> String objectToJson (T obj) {
		String jsonString = "";
		try {
			jsonString = objectMapper.writeValueAsString(obj);
		} catch (JsonProcessingException e) {
			log.error("Parsing Exception " + e);
		}
		return jsonString;
	}

	public static <T> T jsonToObject(String jsonString, Class<T> toClass) {
		T obj = null;
		try {
			obj = objectMapper.readValue(jsonString, toClass);
		} catch (IOException e) {
			log.error("IOException Exception " + e);
		}
		return obj;
	}
}
