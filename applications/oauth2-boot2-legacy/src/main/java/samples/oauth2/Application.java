package samples.oauth2;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.oauth2.client.OAuth2ClientContext;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.client.resource.OAuth2ProtectedResourceDetails;
import samples.oauth2.service.DownstreamServiceHandler;

@SpringBootApplication
public class Application {
	@Value("${resourceServerUrl}")
	private String resourceServerUrl;

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Bean
	public OAuth2RestTemplate oAuth2RestTemplate(OAuth2ProtectedResourceDetails oAuth2ProtectedResourceDetails,
																							 OAuth2ClientContext oAuth2ClientContext) {
		return new OAuth2RestTemplate(oAuth2ProtectedResourceDetails, oAuth2ClientContext);
	}

	@Bean
	public DownstreamServiceHandler downstreamServiceHandler(OAuth2RestTemplate oAuth2RestTemplate) {
		return new DownstreamServiceHandler(oAuth2RestTemplate, resourceServerUrl);
	}
}
