json.data do
    json.array! @blog do |record|
    json.id record.id
    json.title record.title
    json.description record.description
    end
end