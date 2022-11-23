import { AppSyncResolverEvent } from 'aws-lambda';

export const handler = async (event: AppSyncResolverEvent<any, any>): Promise<string> => {
   try {
    console.log("### Event ###", event);

    const message = `Successfully created at ${new Date()}`;

    return message;
   } catch (err) {
    console.log("### Error Event ###", err);
    throw new Error("### Error ### Can't process shopify update!");
   }
};
