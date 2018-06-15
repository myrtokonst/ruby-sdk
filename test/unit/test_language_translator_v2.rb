# frozen_string_literal: true

require_relative("./../../lib/watson_developer_cloud.rb")
require("minitest/autorun")
require("webmock/minitest")

WebMock.disable_net_connect!(allow_localhost: true)

# Unit tests for the Language Translator V2 Service
class LanguageTranslatorV2Test < Minitest::Test
  def test_translate_source_target
    expected = {
      "translations" => [
        {
          "translation" => "Hello, how are you ? \u20ac"
        }
      ],
      "word_count" => 4,
      "character_count" => 19
    }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:post, "https://gateway.watsonplatform.net/language-translator/api/v2/translate")
      .with(
        body: "{\"text\":\"Hola, cómo estás? €\",\"source\":\"es\",\"target\":\"en\"}",
        headers: {
          "Accept" => "application/json",
          "Authorization" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ=",
          "Content-Type" => "application/json",
          "Host" => "gateway.watsonplatform.net"
        }
      ).to_return(status: 200, body: expected.to_json, headers: headers)
    service = WatsonDeveloperCloud::LanguageTranslatorV2.new(
      username: "username",
      password: "password"
    )
    expected_response = DetailedResponse.new(status: 200, headers: headers, body: expected)
    service_response = service.translate(text: "Hola, cómo estás? €", source: "es", target: "en")
    assert_equal(expected_response.status, service_response.status)
    assert_equal(expected_response.body, service_response.body)
    expected_response.headers.each_key do |key|
      assert(service_response.headers.key?(key))
      assert(expected_response.headers[key] == service_response.headers[key])
    end
  end

  def test_translate_model_id
    expected = {
      "character_count" => 22,
      "translations" => [
        {
          "translation" => "Messi es el mejor"
        }
      ],
      "word_count" => 5
    }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:post, "https://gateway.watsonplatform.net/language-translator/api/v2/translate")
      .with(
        body: "{\"text\":\"Messi is the best ever\",\"model_id\":\"en-es-conversational\"}",
        headers: {
          "Accept" => "application/json",
          "Authorization" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ=",
          "Content-Type" => "application/json",
          "Host" => "gateway.watsonplatform.net"
        }
      ).to_return(status: 200, body: expected.to_json, headers: headers)
    service = WatsonDeveloperCloud::LanguageTranslatorV2.new(
      username: "username",
      password: "password"
    )
    expected_response = DetailedResponse.new(status: 200, headers: headers, body: expected)
    service_response = service.translate(text: "Messi is the best ever", model_id: "en-es-conversational")
    assert_equal(expected_response.status, service_response.status)
    assert_equal(expected_response.body, service_response.body)
    expected_response.headers.each_key do |key|
      assert(service_response.headers.key?(key))
      assert(expected_response.headers[key] == service_response.headers[key])
    end
  end

  def test_list_models
    expected = {
      "models" => [
        {
          "status" => "available",
          "model_id" => "en-es-conversational",
          "domain" => "conversational",
          "target" => "es",
          "customizable" => false,
          "source" => "en",
          "base_model_id" => "",
          "owner" => "",
          "default_model" => false,
          "name" => "en-es-conversational"
        },
        {
          "status" => "available",
          "model_id" => "es-en",
          "domain" => "news",
          "target" => "en",
          "customizable" => true,
          "source" => "es",
          "base_model_id" => "",
          "owner" => "",
          "default_model" => true,
          "name" => "es-en"
        }
      ]
    }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://gateway.watsonplatform.net/language-translator/api/v2/models")
      .with(
        headers: {
          "Accept" => "application/json",
          "Authorization" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ=",
          "Host" => "gateway.watsonplatform.net"
        }
      ).to_return(status: 200, body: expected.to_json, headers: headers)
    service = WatsonDeveloperCloud::LanguageTranslatorV2.new(
      username: "username",
      password: "password"
    )
    expected_response = DetailedResponse.new(status: 200, headers: headers, body: expected)
    service_response = service.list_models
    assert_equal(expected_response.status, service_response.status)
    expected_response.body.each_key do |key|
      assert(service_response.body.key?(key))
      expected_response.body[key].each do |hash|
        temp = service_response.body[key].select do |val|
          hash.eql?(val)
        end
        assert(!temp.empty?)
      end
    end
    expected_response.headers.each_key do |key|
      assert(service_response.headers.key?(key))
      assert(expected_response.headers[key] == service_response.headers[key])
    end
  end

  def test_get_model
    expected = {
      "status" => "available",
      "model_id" => "en-es-conversational",
      "domain" => "conversational",
      "target" => "es",
      "customizable" => false,
      "source" => "en",
      "base_model_id" => "",
      "owner" => "",
      "default_model" => false,
      "name" => "en-es-conversational"
    }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://gateway.watsonplatform.net/language-translator/api/v2/models/en-es-conversational")
      .with(
        headers: {
          "Accept" => "application/json",
          "Authorization" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ=",
          "Host" => "gateway.watsonplatform.net"
        }
      ).to_return(status: 200, body: expected.to_json, headers: headers)
    service = WatsonDeveloperCloud::LanguageTranslatorV2.new(
      username: "username",
      password: "password"
    )
    expected_response = DetailedResponse.new(status: 200, headers: headers, body: expected)
    service_response = service.get_model(model_id: "en-es-conversational")
    assert_equal(expected_response.status, service_response.status)
    assert_equal(expected_response.body, service_response.body)
    expected_response.headers.each_key do |key|
      assert(service_response.headers.key?(key))
      assert(expected_response.headers[key] == service_response.headers[key])
    end
  end

  def test_identify
    expected = {
      "languages" => [
        {
          "confidence" => 0.477673,
          "language" => "zh"
        },
        {
          "confidence" => 0.262053,
          "language" => "zh-TW"
        },
        {
          "confidence" => 0.00958378,
          "language" => "en"
        }
      ]
    }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:post, "https://gateway.watsonplatform.net/language-translator/api/v2/identify")
      .with(
        body: "祝你有美好的一天",
        headers: {
          "Accept" => "application/json",
          "Authorization" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ=",
          "Content-Type" => "text/plain",
          "Host" => "gateway.watsonplatform.net"
        }
      ).to_return(status: 200, body: expected.to_json, headers: headers)
    service = WatsonDeveloperCloud::LanguageTranslatorV2.new(
      username: "username",
      password: "password"
    )
    expected_response = DetailedResponse.new(status: 200, headers: headers, body: expected)
    service_response = service.identify(text: "祝你有美好的一天")
    assert_equal(expected_response.status, service_response.status)
    assert_equal(expected_response.body, service_response.body)
    expected_response.headers.each_key do |key|
      assert(service_response.headers.key?(key))
      assert(expected_response.headers[key] == service_response.headers[key])
    end
  end

  def test_list_identifiable_languages
    expected = {
      "languages" => [
        {
          "name" => "German",
          "language" => "de"
        },
        {
          "name" => "Greek",
          "language" => "el"
        },
        {
          "name" => "English",
          "language" => "en"
        },
        {
          "name" => "Esperanto",
          "language" => "eo"
        },
        {
          "name" => "Spanish",
          "language" => "es"
        },
        {
          "name" => "Chinese",
          "language" => "zh"
        }
      ]
    }
    headers = {
      "Content-Type" => "application/json"
    }
    stub_request(:get, "https://gateway.watsonplatform.net/language-translator/api/v2/identifiable_languages")
      .with(
        headers: {
          "Accept" => "application/json",
          "Authorization" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ=",
          "Host" => "gateway.watsonplatform.net"
        }
      ).to_return(status: 200, body: expected.to_json, headers: headers)
    service = WatsonDeveloperCloud::LanguageTranslatorV2.new(
      username: "username",
      password: "password"
    )
    expected_response = DetailedResponse.new(status: 200, headers: headers, body: expected)
    service_response = service.list_identifiable_languages
    assert_equal(expected_response.status, service_response.status)
    assert_equal(expected_response.body, service_response.body)
    expected_response.headers.each_key do |key|
      assert(service_response.headers.key?(key))
      assert(expected_response.headers[key] == service_response.headers[key])
    end
  end
end
