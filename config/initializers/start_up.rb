# frozen_string_literal: true

endpoints = File.read('lib/config_json/endpoints.json')
ENDPOINTS = OpenStruct.new(JSON.parse(endpoints))
