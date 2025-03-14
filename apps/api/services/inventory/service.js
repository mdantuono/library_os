const { base, Table } = require('../../db');
const mapItem = require('./mapItem');
const items = base(Table.Inventory);

const inventoryFields = [
  'ID',
  'Thing',
  'Name', 
  'Brand',
  'Notes',
  'Due Back',
  'Eye Protection',
  'Active Loans', 
  'Total Loans',
  'Linked Things',
  'Location',
  'Manuals',
  'Picture', 
  'Hidden', 
  'Condition',
  'Estimated Value',
  'is_thing_hidden'
];

const fetchItems = async () => {
  const records = await items.select({
      view: 'api_fetch_things',
      fields: inventoryFields,
      pageSize: 100
  }).all();

  return records.map((r) => mapItem(r));
}

// Tech Debt: "id" here is actually the item number
const fetchItem = async (id, { recordId } = { recordId: undefined }) => {
  if (recordId) {
    const record = await items.find(recordId);
    return mapItem(record);
  }

  const records = await items.select({
      view: 'api_fetch_things',
      fields: inventoryFields,
      filterByFormula: `{ID} = '${id}'`,
      pageSize: 100
  }).all();

  if (records.length === 0) {
    return null;
  }

  return mapItem(records[0]);
}

const createItems = async (thingId, { quantity, brand, notes, estimatedValue, hidden, condition, image, manuals }) => {
  const inventoryData = Array.from(Array(Number(quantity))).map(() => ({
      fields: {
          'Thing': [thingId],
          'Brand': brand,
          'Condition': condition,
          'Notes': notes,
          'Estimated Value': Number(estimatedValue),
          'Hidden': hidden,
          'Picture': image?.url ? [{ url: image.url }] : [],
          'Manuals': manuals
      }
  }));

  const records = await items.create(inventoryData);
  return records.map(mapItem);
}

const updateItem = async (id, { brand, notes, estimatedValue, hidden, condition, image, manuals }) => {
  let updatedFields = {};

  if (brand !== null) {
      updatedFields['Brand'] = brand;
  }

  if (notes !== null) {
      updatedFields['Notes'] = notes;
  }

  if (estimatedValue !== null) {
      updatedFields['Estimated Value'] = estimatedValue;
  }

  if (hidden !== null) {
      updatedFields['Hidden'] = hidden;
  }

  if (condition !== null) {
      updatedFields['Condition'] = condition;
  }

  if (image !== null) {
      updatedFields['Picture'] = image.url ? [{ url: image.url }] : [];
  }

  if (manuals !== null) {
      updatedFields['Manuals'] = manuals;
  }

  await items.update(id, updatedFields);
}

const convertItem = async (id, thingId) => {
  await items.update(id, { Thing: [thingId] });
}

const deleteItem = async (id) => {
  await items.destroy(id);
}

module.exports = {
  fetchItems,
  fetchItem,
  createItems,
  updateItem,
  convertItem,
  deleteItem
};